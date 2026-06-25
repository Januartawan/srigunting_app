import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'pricelist_program_detail_event.dart';
part 'pricelist_program_detail_state.dart';

class PricelistProgramDetailBloc extends ABlocManagement<
    PricelistProgramDetailEvent, PricelistProgramDetailState> {
  final InformationRepository _informationRepository;

  PricelistProgramDetailBloc(this._informationRepository)
      : super(PricelistProgramDetailInitial()) {
    on<PricelistProgramDetailInitialEvent>((event, emit) async {
      try {
        emit(PricelistProgramDetailInitialLoading());

        var res =
            await _informationRepository.fetchPricelistProgramDetail(event.media);

        responseHandler<List<String>>(res, onSuccess: (response) {
          emit(PricelistProgramDetailInitialLoaded(imageUrls: response ?? []));
        }, onError: (dioError, code, errorMessage) {
          emit(PricelistProgramDetailInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(PricelistProgramDetailInitialError(error: e.toString()));
      }
    });
  }
}
