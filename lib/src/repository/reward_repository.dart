import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/reward.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/repository/request/free_ticket_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/repository/pagination.dart';

abstract class RewardRepository {
  Future<Result<Balance>> showPointReward();
  Future<Result<Balance>> showPointUndian();
  Future<Result<List<Transaction>>> fetchPointHistory();
  Future<Result<Balance>> showPointDetail();
  Future<Result<List<Reward>>> fetchReward();
  Future<Result<Reward>> showReward();
  Future<Result<FreeVisit>> showFreeVisit();
  Future<Result<FreeVisit>> useFreeTicket(FreeTicketRequest request);
  Future<Result<Pagination<Transaction>>> fetchPointHistoryPaginated(
      PaginationRequest request);
}
