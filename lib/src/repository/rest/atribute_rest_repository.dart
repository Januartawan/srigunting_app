import 'package:srigunting_app/src/domain/atribute.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/atribute_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';
class AtributeRestRepository extends BaseRemote implements AtributeRepository {
  AtributeRestRepository(super.dio);
  @override
  Future<Result<Atribute>> fetchBaseArea() async {
    var result = await getMethod(ApiUrl.baseArea,
        converter: ((response) => Atribute.fromMap(response)));
    return result;
  }
  @override
  Future<Result<Atribute>> fetchCity() async {
    var result = await getMethod(ApiUrl.city,
        converter: ((response) => Atribute.fromMap(response)));
    return result;
  }
  @override
  Future<Result<List<Atribute>>> fetchGender() async {
    var result = await getMethod(ApiUrl.gender,
        converter: ((response) => List<Atribute>.from(
            response['data'].map((x) => Atribute.fromMap(x)))));
    return result;
  }
  @override
  Future<Result<Atribute>> fetchMaritalStatus() async {
    var result = await getMethod(ApiUrl.marriageStatus,
        converter: ((response) => Atribute.fromMap(response)));
    return result;
  }
  @override
  Future<Result<List<Atribute>>> fetchReligion() async {
    var result = await getMethod(ApiUrl.religion,
        converter: ((response) => List<Atribute>.from(
            response['data'].map((x) => Atribute.fromMap(x)))));
    return result;
  }
}