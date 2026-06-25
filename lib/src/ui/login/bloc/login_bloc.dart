import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/login_response.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends ABlocManagement<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final LocalStorageRepository _localStorageRepository;

  LoginBloc(this._authRepository, this._localStorageRepository)
      : super(LoginInitial()) {
    on<LoginInitialEvent>((event, emit) async {});

    on<LoginExecuteEvent>((event, emit) async {
      try {
        emit(LoginLoading());

        var res = await _authRepository.login(
            username: event.username, password: event.password);

        await responseHandler<LoginResponse>(res, onSuccess: (data) {
          _localStorageRepository.write(
              LocalStorageKey.AUTH_TOKEN, 'Bearer ${data?.data?.token}' ?? '');
          // ..write(LocalStorageKey.IS_LOGGED_IN, 'true');

          // _authRepository.loginSuccess();x

          emit(LoginSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(LoginError(error: errorMessage));
        });
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    });
  }
}
