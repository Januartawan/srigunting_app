import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
part 'initial_loading_event.dart';
part 'initial_loading_state.dart';
class InitialLoadingBloc
    extends ABlocManagement<InitialLoadingEvent, InitialLoadingState> {
  final LocalStorageRepository _localStorageRepository;
  InitialLoadingBloc(this._localStorageRepository)
      : super(InitialLoadingInitial()) {
    on<InitialLoadingExecuteEvent>((event, emit) async {
      try {
        var token = await _localStorageRepository.read(LocalStorageKey.AUTH_TOKEN);
        if (token?.isNotEmpty ?? false) {
          emit(InitialHasToken());
        } else {
          emit(InitialLogin());
        }
      } catch (e) {
        emit(InitialLogin());
      }
    });
  }
}