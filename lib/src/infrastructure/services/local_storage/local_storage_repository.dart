// ignore_for_file: constant_identifier_names

abstract class LocalStorageRepository {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> deleteAll();
  Future<void> delete(String key);
}

class LocalStorageKey {
  static const GUIDE_CODE = "guide_code";
  static const AUTH_TOKEN = "auth_token";
  static const GUIDE_NAME = "guide_name";
  static const IS_LOGGED_IN = "is_logged_in";
}
