import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/transaction_detail.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/balance_repopsitory.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'commision_history_detail_event.dart';
part 'commision_history_detail_state.dart';

class CommisionHistoryDetailBloc extends ABlocManagement<
    CommisionHistoryDetailEvent, CommisionHistoryDetailState> {
  final BalanceRepopsitory _balanceRepopsitory;

  CommisionHistoryDetailBloc(this._balanceRepopsitory)
      : super(CommisionHistoryDetailInitial()) {
    on<CommisionHistoryDetailInitialEvent>((event, emit) async {
      try {
        emit(CommisionHistoryDetailLoading());

        var res =
            await _balanceRepopsitory.showTransactionDetail(event.trxCode);

        await responseHandler<TransactionDetail>(res, onSuccess: (response) {
          emit(CommisionHistoryDetailLoaded(
            transaction: event.transaction,
            transactionDetail: response!,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionHistoryDetailError(error: errorMessage));
        });
      } catch (e) {
        emit(CommisionHistoryDetailError(error: e.toString()));
      }
    });
  }
}
