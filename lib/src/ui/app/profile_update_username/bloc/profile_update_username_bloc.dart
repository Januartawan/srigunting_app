import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'profile_update_username_event.dart';
part 'profile_update_username_state.dart';

class ProfileUpdateUsernameBloc extends ABlocManagement<
    ProfileUpdateUsernameEvent, ProfileUpdateUsernameState> {
  final AuthRepository _authRepository;

  ProfileUpdateUsernameBloc(this._authRepository)
      : super(ProfileUpdateUsernameInitial()) {
    on<ProfileUpdateUsernameExecuteEvent>((event, emit) async {
      try {
        emit(ProfileUpdateUsernameExecuteLoading());
        var res = await _authRepository.updateUsername(
            username: event.username, password: event.password);
        await responseHandler(res, onSuccess: (response) {
          emit(ProfileUpdateUsernameExecuteSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileUpdateUsernameExecuteError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileUpdateUsernameExecuteError(error: e.toString()));
      }
    });
  }
}
