import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/transaction_detail.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/balance_repopsitory.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/infrastructure/extention/query_param.dart';

class BalanceRestRepository extends BaseRemote implements BalanceRepopsitory {
  BalanceRestRepository(super.dio);

  @override
  Future<Result<Pagination<Transaction>>> fetchHistoryTransaction(
      PaginationRequest request) async {
    var url = ApiUrl.SUSUK_HISTORY.queryParam(request.toJson());
    var result = await getMethod(
      url,
      converter: ((response) {
        var meta = response['meta'] ?? response;
        // Jika meta kosong (array atau null), set default meta
        if (meta == null || (meta is List && meta.isEmpty)) {
          meta = {
            "total": 0,
            "current_page": 1,
            "per_page": 10,
            "last_page": 1
          };
        }
        final dataList = List<Transaction>.from(
          (response['data'] ?? []).map((x) => Transaction.fromMap(x)),
        );
        return Pagination<Transaction>.fromJson(meta, dataList);
      }),
    );
    return result;
  }

  @override
  Future<Result<Balance>> showBalance() async {
    var result = await getMethod(ApiUrl.BALANCE, converter: ((response) {
      if (response["data"] == null ||
          (response["data"] is List && response["data"].isEmpty)) {
        return Balance();
      }
      return Balance.fromMap(response["data"]);
    }));

    return result;
  }

  @override
  Future<Result> showDetail() async {
    var result = await getMethod(ApiUrl.SUSUK_DETAIL,
        converter: ((response) => Balance.fromMap(response)));

    return result;
  }

  @override
  Future<Result<TransactionDetail>> showTransactionDetail(
      String trxCode) async {
    var url = "${ApiUrl.SUSUK_DETAIL}?trx_code=$trxCode";
    var result = await getMethod(
      url,
      converter: ((response) => TransactionDetail.fromMap(response["data"])),
    );
    return result;
  }
}
