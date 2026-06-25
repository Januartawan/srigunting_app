import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/free_visit_detail_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

class FreeVisitDetailRestRepository extends BaseRemote
    implements FreeVisitDetailRepository {
  FreeVisitDetailRestRepository(super.dio);

  @override
  Future<Result<FreeVisit>> showFreeVisitDetail() async {
    var result = await getMethod(ApiUrl.FREE_VISIT_DETAIL,
        converter: ((response) => FreeVisit.fromMap(response["data"])));

    return result;
  }
}
