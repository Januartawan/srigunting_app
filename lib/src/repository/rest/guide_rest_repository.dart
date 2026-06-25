import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

class GuideRestRepository extends BaseRemote implements GuideRepository {
  GuideRestRepository(super.dio);

  @override
  Future<Result<Guide>> detailAccountSrigunting() async {
    var result = await getMethod(ApiUrl.GUIDE_AKUN_APPS,
        converter: ((response) => Guide.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<Guide>> showGuide() async {
    var result = await getMethod<Guide>(ApiUrl.DETAIL_GUIDE,
        converter: ((response) => Guide.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result> updateGuide(RegisterRequest payload) async {
    var p = payload.toMap();
    var result = await patchMethod(ApiUrl.GUIDE_UPDATE,
        body: p, converter: ((response) => response));

    return result;
  }
}
