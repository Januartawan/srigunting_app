import 'package:kiwi/kiwi.dart';
import 'package:srigunting_app/src/infrastructure/navigation/nav_key.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class ErrorCode {
  static const EMAIL_UNVERIFIED = "EMAIL-UNVERIFIED";
}

String handleError(result) {
  String errorMessage;
  try {
    switch (result.errorBody["code"]) {
      case 404:
        errorMessage = "Terjadi kesalahan";
        break;
      case "VALIDATION_ERROR":
        errorMessage = "Data masih belum lengkap";
        break;
      case ErrorCode.EMAIL_UNVERIFIED:
        errorMessage = "Email belum diverifikasi";
        break;
      case "LOGIN-FAILED":
        errorMessage = "Login gagal, periksa email/password anda";
        break;
      case "AUTH-INVALID_TOKEN":
        errorMessage = "Sesi login anda berakhir!";
        // // Menutup semua halaman dan navigasi ke halaman login
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
