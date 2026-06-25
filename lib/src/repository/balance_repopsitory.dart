import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/transaction_detail.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class BalanceRepopsitory {
  Future<Result<Balance>> showBalance();
  Future<Result<Pagination<Transaction>>> fetchHistoryTransaction(
      PaginationRequest request);
  Future<Result> showDetail();
  Future<Result<TransactionDetail>> showTransactionDetail(String trxCode);
}
