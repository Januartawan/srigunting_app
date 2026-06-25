import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/pricelist_program.dart';
import 'package:srigunting_app/src/infrastructure/extention/query_param.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

class InformationRestRepository extends BaseRemote
    implements InformationRepository {
  InformationRestRepository(super.dio);

  @override
  Future<Result<Pagination<Information>>> fetchInformation(
      PaginationRequest request) async {
    var url = ApiUrl.INFORMATION_LIST.queryParam(request.toJson());
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
        final dataList = List<Information>.from(
          (response['data'] ?? []).map((x) => Information.fromJson(x)),
        );
        return Pagination<Information>.fromJson(meta, dataList);
      }),
    );

    return result;
  }

  @override
  Future<Result<Information>> showInformation(String slug) async {
    var result = await getMethod('${ApiUrl.INFORMATION_DETAIL}/?slug=$slug',
        converter: ((response) => Information.fromJson(response['data'])));
    return result;
  }

  @override
  Future<Result<List<String>>> fetchSkemaSusukImages() async {
    var result = await getMethod<List<String>>(
      ApiUrl.SKEMA_SUSUK,
      headers: const {'Accept': 'application/json'},
      converter: ((response) {
        if (response is! Map || response['data'] is! List) {
          throw Exception(response is Map
              ? response['message'] ?? 'Data skema susuk tidak valid'
              : 'Data skema susuk tidak valid');
        }

        return List<String>.from(response['data']);
      }),
    );
    return result;
  }

  @override
  Future<Result<List<String>>> fetchFlowSusukImages() async {
    var result = await getMethod<List<String>>(
      ApiUrl.FLOW_SUSUK,
      headers: const {'Accept': 'application/json'},
      converter: ((response) {
        if (response is! Map || response['data'] is! List) {
          throw Exception(response is Map
              ? response['message'] ?? 'Data flow klaim tidak valid'
              : 'Data flow klaim tidak valid');
        }

        return List<String>.from(response['data']);
      }),
    );
    return result;
  }

  @override
  Future<Result<List<PricelistProgram>>> fetchPricelistProgram() async {
    var result = await getMethod<List<PricelistProgram>>(
      ApiUrl.PRICELIST_PROGRAM,
      headers: const {'Accept': 'application/json'},
      converter: ((response) {
        if (response is! Map || response['data'] is! List) {
          throw Exception(response is Map
              ? response['message'] ?? 'Data pricelist program tidak valid'
              : 'Data pricelist program tidak valid');
        }

        return List<PricelistProgram>.from(
          response['data'].map((x) => PricelistProgram.fromJson(x)),
        );
      }),
    );
    return result;
  }

  @override
  Future<Result<List<String>>> fetchPricelistProgramDetail(
      String media) async {
    var url = ApiUrl.PRICELIST_PROGRAM_DETAIL.queryParam({'media': media});
    var result = await getMethod<List<String>>(
      url,
      headers: const {'Accept': 'application/json'},
      converter: ((response) {
        if (response is! Map || response['data'] is! List) {
          throw Exception(response is Map
              ? response['message'] ?? 'Data detail tidak valid'
              : 'Data detail tidak valid');
        }

        return List<String>.from(response['data']);
      }),
    );
    return result;
  }
}
