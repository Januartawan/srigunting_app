import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print("Body Request");
    }
    if (options.data is! FormData) {
      final prettyJson = const JsonEncoder.withIndent("  ").convert(options.data);
      if (kDebugMode) {
        print(prettyJson);
      }
    }
    super.onRequest(options, handler);
  }
}