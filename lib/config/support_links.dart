/// Configuration for the optional "support development" links.
///
/// These are voluntary donation links. They unlock NOTHING in the app —
/// every feature is free for everyone regardless. Keeping donations free of
/// any in-app benefit is both the project's philosophy and what keeps the
/// app compliant with Google Play's payments policy (external donation links
/// are allowed precisely because they grant no digital content).
class SupportLinks {
  const SupportLinks._();

  /// Ko-fi "buy me a coffee" page.
  ///
  /// TODO(crest): replace YOUR_HANDLE with the real Ko-fi handle before
  /// publishing. If you have not created a Ko-fi page yet, sign up at
  /// https://ko-fi.com and put your page name here.
  static const String kofi = 'https://ko-fi.com/YOUR_HANDLE';

  /// Whether the support entry should be shown. Set to false to hide the
  /// whole feature (e.g. for an F-Droid build, which disallows donation
  /// nags in-app).
  static const bool enabled = true;
}
