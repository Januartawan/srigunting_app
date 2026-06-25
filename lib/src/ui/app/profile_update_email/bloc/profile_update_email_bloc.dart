import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'profile_update_email_event.dart';
part 'profile_update_email_state.dart';

class ProfileUpdateEmailBloc
    extends ABlocManagement<ProfileUpdateEmailEvent, ProfileUpdateEmailState> {
  final AuthRepository _authRepository;

  ProfileUpdateEmailBloc(this._authRepository)
      : super(ProfileUpdateEmailInitial()) {
    on<ProfileUpdateEmailExecuteEvent>((event, emit) async {
      try {
        emit(ProfileUpdateEmailExecuteLoading());
        var res = await _authRepository.updateEmail(
            email: event.email, password: event.password);
        await responseHandler(res, onSuccess: (response) {
          emit(ProfileUpdateEmailExecuteSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileUpdateEmailExecuteError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileUpdateEmailExecuteError(error: e.toString()));
      }
    });
  }
}
