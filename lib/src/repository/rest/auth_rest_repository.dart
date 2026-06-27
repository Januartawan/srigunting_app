import 'package:shared_preferences/shared_preferences.dart';
import 'package:srigunting_app/src/domain/login_response.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
class AuthRestRepository extends BaseRemote implements AuthRepository {
  AuthRestRepository(super.dio);
  @override
  Future<Result<LoginResponse>> login(
      {required String username, required String password}) async {
    var url = ApiUrl.login;
    var result = await postMethod(url,
        body: {"username": username, "password": password},
        converter: ((response) => LoginResponse.fromMap(response)));
    return result;
  }
  @override
  Future<Result> logout() async {
    var result = await postMethod(ApiUrl.logout,
        body: {}, converter: (response) => response);
    return result;
  }
  @override
  Future<Result> register(RegisterRequest payload) async {
    var result = await postMethod(ApiUrl.register,
        body: payload.toMap(), converter: (response) => response);
    return result;
  }
  @override
  Future<Result> updateEmail(
      {required String email, required String password}) async {
    var result = await patchMethod(ApiUrl.changeEmail,
        body: {"email": email, "password": password},
        converter: (response) => response);
    return result;
  }
  @override
  Future<Result> updatePassword(
      {required String newPassword, required String oldPassword}) async {
    var result = await patchMethod(ApiUrl.changePassword,
        body: {"password_baru": newPassword, "password_lama": oldPassword},
        converter: (response) => response);
    return result;
  }
  @override
  Future<Result> updateUsername(
      {required String username, required String password}) async {
    var result = await patchMethod(ApiUrl.changeUsername,
        body: {"username": username, "password": password},
        converter: (response) => response);
    return result;
  }
  @override
  Future<void> loginSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }
  @override
  Future<void> logoutSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
  @override
  Future<Result> updateDeviceToken({
    required String deviceToken,
    required String platform,
  }) async {
    var result = await patchMethod(ApiUrl.deviceToken,
        body: {
          "device_token": deviceToken,
          "platform": platform,
        },
        converter: (response) => response);
    return result;
  }
}