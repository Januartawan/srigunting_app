import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
part 'information_detail_event.dart';
part 'information_detail_state.dart';
class InformationDetailBloc
    extends ABlocManagement<InformationDetailEvent, InformationDetailState> {
  final InformationRepository _informationRepository;
  InformationDetailBloc(this._informationRepository)
      : super(InformationDetailInitial()) {
    on<InformationDetailInitialEvent>((event, emit) async {
      try {
        emit(InformationDetailInitialLoading());
        var res = await _informationRepository.showInformation(event.slug);
        responseHandler<Information>(res, onSuccess: (response) {
          emit(InformationDetailInitialLoaded(
              dataInformation: response ?? Information()));
        }, onError: (dioError, code, errorMessage) {
          emit(InformationDetailInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(InformationDetailInitialError(error: e.toString()));
      }
    });
  }
}