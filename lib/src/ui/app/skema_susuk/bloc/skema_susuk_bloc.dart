import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'skema_susuk_event.dart';
part 'skema_susuk_state.dart';

class SkemaSusukBloc extends ABlocManagement<SkemaSusukEvent, SkemaSusukState> {
  final InformationRepository _informationRepository;

  SkemaSusukBloc(this._informationRepository) : super(SkemaSusukInitial()) {
    on<SkemaSusukInitialEvent>((event, emit) async {
      try {
        emit(SkemaSusukInitialLoading());

        var res = await _informationRepository.fetchSkemaSusukImages();

        responseHandler<List<String>>(res, onSuccess: (response) {
          emit(SkemaSusukInitialLoaded(imageUrls: response ?? []));
        }, onError: (dioError, code, errorMessage) {
          emit(SkemaSusukInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(SkemaSusukInitialError(error: e.toString()));
      }
    });
  }
}
