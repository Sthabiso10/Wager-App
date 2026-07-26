/// Convex deployment configuration.
///
/// After running `npx convex dev`, paste your deployment URL here (looks like
/// `https://<name>.convex.cloud`) — or pass it at build time with
/// `--dart-define=CONVEX_URL=https://<name>.convex.cloud`.
///
/// While this is empty, Convex stays fully disabled and the app behaves exactly
/// as before, so you can wire screens over one at a time.
class ConvexEnv {
  ConvexEnv._();

  static const String deploymentUrl = String.fromEnvironment(
    'CONVEX_URL',
    defaultValue: '', // e.g. 'https://your-deployment.convex.cloud'
  );

  static bool get isConfigured => deploymentUrl.isNotEmpty;
}
