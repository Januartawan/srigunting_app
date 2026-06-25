import 'dart:developer';

import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit,
      {bool withPrefix = true, bool sorten = false}) {
    try {
      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: withPrefix ? 'Rp ' : '',
        decimalDigits: decimalDigit,
      );

      return currencyFormatter.format(number);
    } catch (e) {
      log(e.toString());
      return "-";
    }
  }

  static int reverseFromIdr(String idr) {
    try {
      var number = idr.replaceAll(".", "").split(",");
      return int.tryParse(number[0]) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static num toDouble(String number) {
    return num.tryParse(number.replaceAll(".", "")) ?? 0;
  }
}
