// Smoke tests for app-level constants and theming.
//
// Widget-tree tests for MyApp itself (lib/main.dart) need Firebase to be
// initialized first, since the initial route builds screens that read
// FirebaseAuth state. That requires a Firebase test double (e.g. the
// firebase_auth_mocks / fake_cloud_firestore packages) which isn't wired up
// yet — see CONVEX_MIGRATION.md for the plan to replace that Firestore
// dependency with Convex, after which these tests can cover real screens.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wager_app/app/constants/strings.dart';
import 'package:wager_app/styles/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('app name is Watt', () {
    expect(appName, 'Watt');
  });

  test('appTheme builds a Material 3 light theme', () {
    final theme = appTheme(textTheme: const TextTheme());

    expect(theme.useMaterial3, isTrue);
    expect(theme.colorScheme.brightness, Brightness.light);
  });
}
