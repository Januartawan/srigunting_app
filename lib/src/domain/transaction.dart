class Transaction {
  final String? trxCode;
  final String? status;
  final String? point;
  final num? susuk;
  final String? trxDate;

  Transaction({
    this.trxCode,
    this.status,
    this.point,
    this.susuk,
    this.trxDate,
  });

  Transaction copyWith({
    String? trxCode,
    String? status,
    String? point,
    num? susuk,
    String? trxDate,
  }) =>
      Transaction(
        trxCode: trxCode ?? this.trxCode,
        status: status ?? this.status,
        point: point ?? this.point,
        susuk: susuk ?? this.susuk,
        trxDate: trxDate ?? this.trxDate,
      );

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        trxCode: json["trx_code"],
        status: json["status"],
        point: json["point"],
        susuk: json["susuk"],
        trxDate: json["trx_date"],
      );

  Map<String, dynamic> toMap() => {
        "trx_code": trxCode,
        "status": status,
        "point": point,
        "susuk": susuk,
        "trx_date": trxDate,
      };
}
