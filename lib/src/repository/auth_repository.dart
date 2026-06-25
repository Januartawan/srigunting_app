import 'package:srigunting_app/src/domain/login_response.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class AuthRepository {
  Future<Result<LoginResponse>> login(
      {required String username, required String password});
  Future<Result> register(RegisterRequest payload);
  Future<Result> logout();
  Future<Result> updateUsername(
      {required String username, required String password});
  Future<Result> updateEmail({required String email, required String password});
  Future<Result> updatePassword(
      {required String newPassword, required String oldPassword});
  Future<void> loginSuccess();
  Future<void> logoutSuccess();
  Future<Result> updateDeviceToken({
    required String deviceToken,
    required String platform,
  });
}
