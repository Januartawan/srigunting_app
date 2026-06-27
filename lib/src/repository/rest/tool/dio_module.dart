import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/env.dart';
import 'package:srigunting_app/src/repository/rest/tool/auth_interceptor.dart';
import 'package:srigunting_app/src/repository/rest/tool/retry_interceptor.dart';

class DioModule with DioMixin implements Dio {
  final LocalStorageRepository localStorageRepository;

  DioModule(this.localStorageRepository) {
    options = BaseOptions(
      baseUrl: apiUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      validateStatus: (status) {
        return status != null && status < 500;
      },
      followRedirects: true,
      maxRedirects: 5,
    );

    options = options;
    httpClientAdapter = HttpClientAdapter();

    interceptors.add(AuthInterceptor(localStorageRepository));
    interceptors.add(RetryInterceptor(
        maxRetries: 3, retryDelay: const Duration(seconds: 2)));
    interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    // interceptors.add(LoggingInterceptor());
  }
}
