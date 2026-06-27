import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
part 'profile_update_password_event.dart';
part 'profile_update_password_state.dart';
class ProfileUpdatePasswordBloc extends ABlocManagement<
    ProfileUpdatePasswordEvent, ProfileUpdatePasswordState> {
  final AuthRepository _authRepository;
  ProfileUpdatePasswordBloc(this._authRepository)
      : super(ProfileUpdatePasswordInitial()) {
    on<ProfileUpdatePasswordExecute>((event, emit) async {
      try {
        emit(ProfileUpdatePasswordLoading());
        var res = await _authRepository.updatePassword(
          newPassword: event.newPassword ?? '',
          oldPassword: event.oldPassword ?? '',
        );
        responseHandler(res, onSuccess: (response) {
          emit(ProfileUpdatePasswordExecuteSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileUpdatePasswordExecuteError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileUpdatePasswordExecuteError(error: e.toString()));
      }
    });
  }
}