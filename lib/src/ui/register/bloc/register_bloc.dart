import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends ABlocManagement<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc(this._authRepository) : super(RegisterInitial()) {
    on<RegisterExecute>((event, emit) async {
      try {
        emit(RegisterExecuteLoading());

        var res = await _authRepository.register(event.payload);

        responseHandler(res, onSuccess: (response) {
          emit(RegisterExecuteSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(RegisterExecuteError(error: errorMessage));
        });
      } catch (e) {
        emit(RegisterExecuteError(error: e.toString()));
      }
    });
  }
}
