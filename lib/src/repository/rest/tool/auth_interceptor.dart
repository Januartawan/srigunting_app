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
    // var outletID =
    //     await _localStorageRepository.read(LocalStorageKey.OUTLET_ID);
    options.headers[Header.AUTHORIZATION] = authID;
    // options.headers[Header.OUTLET] = outletID;
    options.headers[Header.ACCEPT] = 'application/json';
    options.headers[Header.CONTENT_TYPE] = 'application/json';

    super.onRequest(options, handler);
  }
}
