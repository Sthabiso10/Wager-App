import 'dart:convert';

import 'package:convex_flutter/convex_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wager_app/config/convex_config.dart';

/// Thin singleton wrapper around the Convex Flutter client.
///
/// Responsibilities:
///  • initialise the client (no-op until [ConvexEnv.deploymentUrl] is set)
///  • bridge Firebase Auth → Convex (passes the Firebase ID token, auto-refreshed)
///  • decode Convex's JSON-string results into Dart maps/lists
///
/// Convex functions are addressed as `"file:function"`, e.g. `"friends:myFriends"`.
class ConvexService {
  ConvexService._();
  static final ConvexService instance = ConvexService._();

  bool _initialized = false;
  AuthHandleWrapper? _authHandle;

  bool get isReady => _initialized;

  /// Call once at startup. Safe to call when Convex is not yet configured.
  Future<void> init() async {
    if (_initialized || !ConvexEnv.isConfigured) return;
    await ConvexClient.initialize(
      const ConvexConfig(
        deploymentUrl: ConvexEnv.deploymentUrl,
        clientId: 'watt-flutter',
      ),
    );
    _initialized = true;
  }

  ConvexClient get _client => ConvexClient.instance;

  /// Wire Firebase Auth into Convex. Call after a successful sign-in (and on
  /// startup if a user is already signed in). The token auto-refreshes.
  Future<void> bindFirebaseAuth() async {
    if (!_initialized) return;
    _authHandle?.dispose();
    _authHandle = await _client.setAuthWithRefresh(
      fetchToken: () async => FirebaseAuth.instance.currentUser?.getIdToken(),
    );
  }

  /// Clear Convex auth (call this alongside FirebaseAuth.signOut()).
  Future<void> signOut() async {
    if (!_initialized) return;
    _authHandle?.dispose();
    _authHandle = null;
    await _client.clearAuth();
  }

  // --- One-shot calls (results decoded from JSON) ---------------------------

  Future<dynamic> query(String name,
      [Map<String, dynamic> args = const {}]) async {
    final raw = await _client.query(name, args);
    return (raw.isEmpty) ? null : jsonDecode(raw);
  }

  Future<dynamic> mutation(String name,
      [Map<String, dynamic> args = const {}]) async {
    final raw = await _client.mutation(name: name, args: args);
    return (raw.isEmpty) ? null : jsonDecode(raw);
  }

  // --- Live subscriptions ---------------------------------------------------

  /// Subscribe to a Convex query. [onData] receives decoded JSON (usually a
  /// `List<dynamic>` or `Map<String, dynamic>`). Cancel via the returned handle.
  Future<SubscriptionHandle> subscribe(
    String name,
    Map<String, dynamic> args,
    void Function(dynamic data) onData, {
    void Function(String message)? onError,
  }) {
    return _client.subscribe(
      name: name,
      args: args,
      onUpdate: (raw) => onData(raw.isEmpty ? null : jsonDecode(raw)),
      onError: (message, _) => onError?.call(message),
    );
  }
}
