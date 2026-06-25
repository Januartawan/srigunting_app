import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc
    extends ABlocManagement<InformationEvent, InformationState> {
  final InformationRepository _informationRepository;

  InformationBloc(this._informationRepository) : super(InformationInitial()) {
    on<InformationInitialEvent>((event, emit) async {
      try {
        emit(InformationInitialLoading());

        var res = await _informationRepository
            .fetchInformation(PaginationRequest(page: 1, perPage: 10));

        responseHandler<Pagination<Information>>(res, onSuccess: (response) {
          emit(InformationInitialLoaded(
            dataInformation: response?.data ?? [],
            pagination: response,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(InformationInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(InformationInitialError(error: e.toString()));
      }
    });

    on<InformationLoadMoreEvent>((event, emit) async {
      try {
        emit(InformationLoadMoreLoading(
          dataInformation: [],
          pagination: null,
        ));

        var res = await _informationRepository
            .fetchInformation(PaginationRequest(page: event.page, perPage: 10));

        responseHandler<Pagination<Information>>(res, onSuccess: (response) {
          emit(InformationLoadMoreLoaded(
            dataInformation: response?.data ?? [],
            pagination: response,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(InformationLoadMoreError(
            error: errorMessage,
            dataInformation: [],
            pagination: null,
          ));
        });
      } catch (e) {
        emit(InformationLoadMoreError(
          error: e.toString(),
          dataInformation: [],
          pagination: null,
        ));
      }
    });
  }
}
