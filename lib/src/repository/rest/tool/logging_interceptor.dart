import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("Body Request");
    if (options.data is! FormData) {
      final prettyJson = JsonEncoder.withIndent("  ").convert(options.data);

      print(prettyJson);
    }
    super.onRequest(options, handler);
  }
}
