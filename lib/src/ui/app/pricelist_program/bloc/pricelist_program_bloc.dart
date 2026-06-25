import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/domain/pricelist_program.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'pricelist_program_event.dart';
part 'pricelist_program_state.dart';

class PricelistProgramBloc
    extends ABlocManagement<PricelistProgramEvent, PricelistProgramState> {
  final InformationRepository _informationRepository;

  PricelistProgramBloc(this._informationRepository)
      : super(PricelistProgramInitial()) {
    on<PricelistProgramInitialEvent>((event, emit) async {
      try {
        emit(PricelistProgramInitialLoading());

        var res = await _informationRepository.fetchPricelistProgram();

        responseHandler<List<PricelistProgram>>(res, onSuccess: (response) {
          emit(PricelistProgramInitialLoaded(programs: response ?? []));
        }, onError: (dioError, code, errorMessage) {
          emit(PricelistProgramInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(PricelistProgramInitialError(error: e.toString()));
      }
    });
  }
}
