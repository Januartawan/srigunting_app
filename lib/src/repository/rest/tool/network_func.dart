import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/global/global.dart';
import 'package:srigunting_app/src/infrastructure/services/common/random.dart';
import 'package:srigunting_app/src/infrastructure/services/func_log.dart';
import 'package:srigunting_app/src/repository/rest/tool/code_error_handler.dart';
import 'dart:async';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:kiwi/kiwi.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

import 'result.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

List<String> restTask = [];

/// Helper function to format error data into a readable string
String _formatErrorData(dynamic data) {
  if (data == null) return '';

  if (data is String) {
    return data;
  }

  if (data is Map) {
    List<String> errorMessages = [];

    data.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        // Handle validation errors like {"nik": ["The nik has already been taken."]}
        String fieldErrors = value.join(', ');
        errorMessages.add('$key: $fieldErrors');
      } else if (value is String) {
        errorMessages.add('$key: $value');
      } else {
        errorMessages.add('$key: ${value.toString()}');
      }
    });

    return errorMessages.join('\n');
  }

  return data.toString();
}

yieldGlobalLoading() {
  if (restTask.isEmpty) {
    loadingStreamController.sink.add(false);
  } else {
    loadingStreamController.sink.add(true);
  }
}

void showGlobalToastError({String? message}) {
  final context = NavigationService.instance.navigatorKey.currentContext;
  if (context != null) {
    Future.delayed(Duration.zero, () {
      return Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: message ?? "Error",
        icon: const Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: AppColors.bgDangerPrimary.withOpacity(0.97),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    });
  }
}

Future<Result<T>> safeCallApi<T>(
    Future<Response<dynamic>> call, ResponseConverter<T> converter) async {
  var requestID = getRandomString(6);
  try {
    loadingStreamController.sink.add(true);
    loadingProgressStreamController.sink.add(1);

    restTask.add(requestID);

    var response = await call;

    // Cek jika response.data memiliki field 'status' dan bukan 200 (error dari backend)
    if (response.data is Map &&
        response.data['status'] != null &&
        response.data['status'] != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: Response(
          data: response.data,
          statusCode: response.data['status'],
          requestOptions: response.requestOptions,
        ),
        type: DioExceptionType.badResponse,
      );
    }

    var transform = converter(response.data);

    restTask.remove(requestID);

    yieldGlobalLoading();

    return Result.success(transform);
  } on DioException catch (e) {
    logError("dio error", e);
    logError("dio error type", e.type);
    logError("dio error message", e.message);
    logError("dio error response", e.response?.data);
    restTask.remove(requestID);
    yieldGlobalLoading();

    // Show toast if no internet
    // if (e.type == DioExceptionType.connectionTimeout ||
    //     e.type == DioExceptionType.unknown ||
    //     e.type == DioExceptionType.badCertificate ||
    //     e.type == DioExceptionType.badResponse ||
    //     e.type == DioExceptionType.cancel ||
    //     e.type == DioExceptionType.connectionError) {
    //   showGlobalToastError(message: 'Tidak ada koneksi internet');
    // }

    return Result.error(e.type, e.response?.statusCode ?? 500,
        e.response?.data ?? "Network error");
  } catch (e, stackTrace) {
    logError("dio error", e);
    logInfo("dio error", 'Stacktrace $stackTrace');
    restTask.remove(requestID);
    yieldGlobalLoading();

    rethrow;
  }
}

Future<void> responseHandler<T>(dynamic result,
    {required Function(T? data) onSuccess,
    required Function(
            DioExceptionType? dioError, String code, dynamic errorBody)
        onError}) async {
  switch (result.status) {
    case Status.SUCCESS:
      await onSuccess(result.body);
      break;
    case Status.ERROR:
      String errorMessage = 'Terjadi kesalahan';
      if (result.errorBody != null) {
        if (result.errorBody is Map) {
          String message = result.errorBody['message']?.toString() ?? '';
          String dataError = _formatErrorData(result.errorBody['data']);

          // Check for unauthenticated response and auto logout
          if (message == 'Unauthenticated.') {
            logError("responseHandler",
                "Unauthenticated response detected, performing auto logout");
            // Clear all stored data and navigate to login
            KiwiContainer()
                .resolve<LocalStorageRepository>("secure_storage")
                .deleteAll()
                .then(
              (value) {
                NavigationService.instance.navigateTo(Routing.LOGIN);
              },
            );
            errorMessage = 'Sesi login anda berakhir!';
          } else {
            if (message.isNotEmpty && dataError.isNotEmpty) {
              errorMessage = '$message\n$dataError';
            } else if (message.isNotEmpty) {
              errorMessage = message;
            } else if (dataError.isNotEmpty) {
              errorMessage = dataError;
            } else {
              errorMessage = 'Terjadi kesalahan';
            }
          }
        } else {
          errorMessage = result.errorBody.toString();
        }
      }
      logError("responseHandler error",
          "Status: ${result.status}, Code: ${result.code}, ErrorBody: $errorMessage");
      await onError(result.dioError, result.code.toString(), errorMessage);
      break;
    default:
      throw ArgumentError();
  }
}

void responseHandler2<T, T2>(Result<T> result, Result<T2> result2,
    {required Function(T? data, T2? data2) onSuccess,
    required Function(Exception ex) onError}) {
  if (result.status == Status.SUCCESS && result2.status == Status.SUCCESS) {
    onSuccess(result.body, result2.body);
  } else if (result.status == Status.ERROR || result2.status == Status.ERROR) {
    String errorBody1 = result.errorBody?.toString() ?? "Unknown error";
    String errorBody2 = result2.errorBody?.toString() ?? "Unknown error";
    String message =
        "Error : [${result.dioError}, ${result.code}, ${result.errorBody}], [${result2.dioError}, ${result2.code}, ${result2.errorBody}]";
    onError(Exception(message));
  } else {
    throw ArgumentError();
  }
}
