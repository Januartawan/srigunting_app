/// Satu-satunya sumber base URL aplikasi.
///
/// Nilai diambil dari `--dart-define=API_URL=...` saat build (lihat build_apk.sh).
/// Jika tidak di-pass, jatuh ke [defaultValue] di bawah (staging).
///
const String apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: "https://crm.balibirdpark.com",
);