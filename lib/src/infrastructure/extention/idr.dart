import 'package:srigunting_app/src/infrastructure/services/common/concurrency.dart';

extension IDRdoubleN on num? {
  String convertIDR({bool withPrefix = true}) {
    return CurrencyFormat.convertToIdr(this ?? 0, 00, withPrefix: withPrefix);
  }
}
