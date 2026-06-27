import 'dart:io';
import 'package:dio/dio.dart';
import 'package:srigunting_app/src/domain/global/global.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
abstract class BaseRemote {
  final Dio _dio;
  BaseRemote(this._dio);
  Future<Result<T>> getMethod<T>(
    String endpoint, {
    Map<String, String>? headers,
    required ResponseConverter<T> converter,
  }) async {
    Options opsi = Options(headers: headers);
    var response =
        await safeCallApi(_dio.get(endpoint, options: opsi), converter);
    return response;
  }
  Future<Result<T>> postMethod<T>(String endpoint,
      {Map<String, dynamic>? headers,
      dynamic body,
      dynamic formData,
      required ResponseConverter<T> converter}) async {
    dynamic data;
    if (formData != null) {
      data = await BaseRemote.convertMapToFormData(formData);
    } else {
      data = body;
    }
    Options opsi = Options(headers: headers);
    var response = await safeCallApi<T>(
        _dio.post(
          endpoint,
          data: data,
          options: opsi,
          onSendProgress: (count, total) {
            loadingProgressStreamController.sink.add(count / total);
          },
        ),
        converter);
    return response;
  }
  Future<Result<T>> putMethod<T>(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    dynamic formData,
    required ResponseConverter<T> converter,
  }) async {
    dynamic data;
    if (formData != null) {
      data = await BaseRemote.convertMapToFormData(formData);
    } else {
      data = body;
    }
    Options opsi = Options(headers: headers);
    var response = await safeCallApi(
        _dio.put(
          endpoint,
          data: data,
          options: opsi,
          onSendProgress: (count, total) {
            loadingProgressStreamController.sink.add(count / total);
          },
        ),
        converter);
    return response;
  }
  Future<Result<T>> patchMethod<T>(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    dynamic formData,
    required ResponseConverter<T> converter,
  }) async {
    dynamic data;
    if (formData != null) {
      data = await BaseRemote.convertMapToFormData(formData);
    } else {
      data = body;
    }
    Options opsi = Options(headers: headers);
    var response = await safeCallApi(
        _dio.patch(
          endpoint,
          data: data,
          options: opsi,
          onSendProgress: (count, total) {
            loadingProgressStreamController.sink.add(count / total);
          },
        ),
        converter);
    return response;
  }
  Future<Result<T>> deleteMethod<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    required ResponseConverter<T> converter,
  }) async {
    Options opsi = Options(headers: headers);
    var response = await safeCallApi(
        _dio.delete(endpoint, data: body, options: opsi), converter);
    return response;
  }
  static Future<FormData> convertMapToFormData(
      Map<String, dynamic> data) async {
    final formData = FormData();
    for (var entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value != null) {
        if (value is File) {
          formData.files.add(MapEntry(
            key,
            await MultipartFile.fromFile(value.path,
                filename: value.path.split('/').last),
          ));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      }
    }
    return formData;
  }
}