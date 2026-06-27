import 'package:dio/dio.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/repository/rest/header.dart';
class AuthInterceptor extends Interceptor {
  final LocalStorageRepository _localStorageRepository;
  AuthInterceptor(this._localStorageRepository);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var authID = await _localStorageRepository.read(LocalStorageKey.AUTH_TOKEN);
    options.headers[Header.authorization] = authID;
    options.headers[Header.accept] = 'application/json';
    options.headers[Header.contentType] = 'application/json';
    super.onRequest(options, handler);
  }
}