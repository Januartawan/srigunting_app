import 'package:kiwi/kiwi.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
class ErrorCode {
  static const emailUnverified = "EMAIL-UNVERIFIED";
}
String handleError(Result result) {
  String errorMessage;
  try {
    switch (result.errorBody["code"]) {
      case 404:
        errorMessage = "Terjadi kesalahan";
        break;
      case "VALIDATION_ERROR":
        errorMessage = "Data masih belum lengkap";
        break;
      case ErrorCode.emailUnverified:
        errorMessage = "Email belum diverifikasi";
        break;
      case "LOGIN-FAILED":
        errorMessage = "Login gagal, periksa email/password anda";
        break;
      case "AUTH-INVALID_TOKEN":
        errorMessage = "Sesi login anda berakhir!";
        KiwiContainer()
            .resolve<LocalStorageRepository>("secure_storage")
            .deleteAll()
            .then(
          (value) {
            NavigationService.instance.navigateTo(Routing.LOGIN);
          },
        );
        break;
      default:
        errorMessage = result.errorBody["message"];
    }
  } catch (err) {
    errorMessage = "Terjadi kesalahan, jaringan tidak stabil";
  }
  return errorMessage;
}