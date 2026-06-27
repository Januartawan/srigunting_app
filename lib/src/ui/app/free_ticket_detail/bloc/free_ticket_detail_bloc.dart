import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
part 'free_ticket_detail_event.dart';
part 'free_ticket_detail_state.dart';
class FreeTicketDetailBloc
    extends ABlocManagement<FreeTicketDetailEvent, FreeTicketDetailState> {
  final LocalStorageRepository _localStorageRepository;
  FreeTicketDetailBloc(this._localStorageRepository)
      : super(FreeTicketDetailInitial()) {
    on<FreeTicketDetailInitialEvent>((event, emit) async {
      try {
        emit(FreeTicketDetailInitialLoading());
        var res = await _localStorageRepository.read(LocalStorageKey.GUIDE_CODE);
        emit(FreeTicketDetailInitiaSuccess(guideCode: res ?? ''));
      } catch (e) {
        emit(FreeTicketDetailInitialError(error: e.toString()));
      }
    });
  }
}