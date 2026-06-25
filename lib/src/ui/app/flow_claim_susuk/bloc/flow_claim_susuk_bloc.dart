import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'flow_claim_susuk_event.dart';
part 'flow_claim_susuk_state.dart';

class FlowClaimSusukBloc
    extends ABlocManagement<FlowClaimSusukEvent, FlowClaimSusukState> {
  final InformationRepository _informationRepository;

  FlowClaimSusukBloc(this._informationRepository)
      : super(FlowClaimSusukInitial()) {
    on<FlowClaimSusukInitialEvent>((event, emit) async {
      try {
        emit(FlowClaimSusukInitialLoading());

        var res = await _informationRepository.fetchFlowSusukImages();

        responseHandler<List<String>>(res, onSuccess: (response) {
          emit(FlowClaimSusukInitialLoaded(imageUrls: response ?? []));
        }, onError: (dioError, code, errorMessage) {
          emit(FlowClaimSusukInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(FlowClaimSusukInitialError(error: e.toString()));
      }
    });
  }
}
