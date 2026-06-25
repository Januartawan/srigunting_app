import 'package:srigunting_app/src/domain/atribute.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class AtributeRepository {
  Future<Result<Atribute>> fetchCity();
  Future<Result<List<Atribute>>> fetchGender();
  Future<Result<List<Atribute>>> fetchReligion();
  Future<Result<Atribute>> fetchMaritalStatus();
  Future<Result<Atribute>> fetchBaseArea();
}
