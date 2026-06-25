import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/pricelist_program.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class InformationRepository {
  Future<Result<Pagination<Information>>> fetchInformation(
      PaginationRequest request);
  Future<Result<Information>> showInformation(String slug);
  Future<Result<List<String>>> fetchSkemaSusukImages();
  Future<Result<List<String>>> fetchFlowSusukImages();
  Future<Result<List<PricelistProgram>>> fetchPricelistProgram();
  Future<Result<List<String>>> fetchPricelistProgramDetail(String media);
}
