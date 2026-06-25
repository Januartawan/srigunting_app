import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/reward.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/request/free_ticket_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/infrastructure/extention/query_param.dart';

class RewardRestRepository extends BaseRemote implements RewardRepository {
  RewardRestRepository(super.dio);

  @override
  Future<Result<List<Reward>>> fetchReward() async {
    var result = await getMethod(ApiUrl.REWARD_LIST, converter: ((response) {
      if (response["data"] == null ||
          (response["data"] is List && response["data"].isEmpty)) {
        return <Reward>[];
      }
      return List<Reward>.from(response["data"].map((x) => Reward.fromMap(x)));
    }));

    return result;
  }

  @override
  Future<Result<FreeVisit>> showFreeVisit() async {
    var result = await getMethod(ApiUrl.FREE_VISIT,
        converter: ((response) => FreeVisit.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<Balance>> showPointDetail() async {
    var result = await getMethod(ApiUrl.POINT_DETAIL,
        converter: ((response) => Balance.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<Pagination<Transaction>>> fetchPointHistoryPaginated(
      PaginationRequest request) async {
    var url = ApiUrl.POINT_HISTORY.queryParam(request.toJson());
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
  Future<Result<Balance>> showPointReward() async {
    var result = await getMethod(ApiUrl.POINT_REWARD, converter: ((response) {
      if (response["data"] == null ||
          (response["data"] is List && response["data"].isEmpty)) {
        return Balance();
      }
      return Balance.fromMap(response["data"]);
    }));

    return result;
  }

  @override
  Future<Result<Balance>> showPointUndian() async {
    var result = await getMethod(ApiUrl.POINT_UNDIAN, converter: ((response) {
      if (response["data"] == null ||
          (response["data"] is List && response["data"].isEmpty)) {
        return Balance();
      }
      return Balance.fromMap(response["data"]);
    }));

    return result;
  }

  @override
  Future<Result<Reward>> showReward() async {
    var result = await getMethod(ApiUrl.REWARD_DETAIL,
        converter: ((response) => Reward.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<FreeVisit>> useFreeTicket(FreeTicketRequest request) async {
    var result = await postMethod(ApiUrl.FREE_VISIT_CLAIM,
        body: request.toMap(),
        converter: ((response) => FreeVisit.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<List<Transaction>>> fetchPointHistory() async {
    var result = await getMethod(ApiUrl.POINT_HISTORY,
        converter: ((response) => List<Transaction>.from(
            response["data"].map((x) => Transaction.fromMap(x)))));
    return result;
  }
}
