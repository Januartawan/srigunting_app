class TransactionDetail {
  final String? trxCode;
  final String? status;
  final String? ticketNumber;
  final String? nationality;
  final int? adultPax;
  final int? childPax;
  final num? susuk;
  final String? trxDate;
  final String? point;

  TransactionDetail({
    this.trxCode,
    this.status,
    this.ticketNumber,
    this.nationality,
    this.adultPax,
    this.childPax,
    this.susuk,
    this.trxDate,
    this.point,
  });

  TransactionDetail copyWith({
    String? trxCode,
    String? status,
    String? ticketNumber,
    String? nationality,
    int? adultPax,
    int? childPax,
    num? susuk,
    String? trxDate,
    String? point,
  }) =>
      TransactionDetail(
        trxCode: trxCode ?? this.trxCode,
        status: status ?? this.status,
        ticketNumber: ticketNumber ?? this.ticketNumber,
        nationality: nationality ?? this.nationality,
        adultPax: adultPax ?? this.adultPax,
        childPax: childPax ?? this.childPax,
        susuk: susuk ?? this.susuk,
        trxDate: trxDate ?? this.trxDate,
        point: point ?? this.point,
      );

  factory TransactionDetail.fromMap(Map<String, dynamic> json) =>
      TransactionDetail(
        trxCode: json["trx_code"],
        status: json["status"],
        ticketNumber: json["ticket_number"],
        nationality: json["nationality"],
        adultPax: json["adult_pax"],
        childPax: json["child_pax"],
        susuk: json["susuk"],
        trxDate: json["trx_date"],
        point: json["point"],
      );

  Map<String, dynamic> toMap() => {
        "trx_code": trxCode,
        "status": status,
        "ticket_number": ticketNumber,
        "nationality": nationality,
        "adult_pax": adultPax,
        "child_pax": childPax,
        "susuk": susuk,
        "trx_date": trxDate,
        "point": point,
      };
}
