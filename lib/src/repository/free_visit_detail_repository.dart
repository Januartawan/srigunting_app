import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class FreeVisitDetailRepository {
  Future<Result<FreeVisit>> showFreeVisitDetail();
}
