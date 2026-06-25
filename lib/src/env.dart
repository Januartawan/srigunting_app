/// Satu-satunya sumber base URL aplikasi.
///
/// Nilai diambil dari `--dart-define=API_URL=...` saat build (lihat build_apk.sh).
/// Jika tidak di-pass, jatuh ke [defaultValue] di bawah (staging).
///
/// Referensi environment:
/// - production : http://103.166.195.193:1702
/// - staging    : http://103.166.195.193:1706
const String apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: "https://stagingcrm.balibirdpark.com",
);
