abstract class Environment {
  static String get baseURL => const String.fromEnvironment("BASE_URL");
  static bool get previewEnabled => const bool.fromEnvironment("PREVIEW_ENABLED");
}
