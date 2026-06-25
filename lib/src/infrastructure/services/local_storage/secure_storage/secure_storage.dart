import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';

class SecureStorage implements LocalStorageRepository {
  @override
  Future<String?> read(String key) {
    return const FlutterSecureStorage().read(key: key);
  }

  @override
  Future<void> write(String key, String value) {
    return const FlutterSecureStorage().write(key: key, value: value);
  }

  @override
  Future<void> deleteAll() {
    return const FlutterSecureStorage().deleteAll();
  }

  @override
  Future<void> delete(String key) {
    return const FlutterSecureStorage().delete(key: key);
  }
}
