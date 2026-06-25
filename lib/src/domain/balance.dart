class Balance {
  final num? balance;
  final String? updatedAt;
  final String? totalPoint;

  Balance({this.balance, this.updatedAt, this.totalPoint});

  Balance copyWith({num? balance, String? updatedAt, String? totalPoint}) =>
      Balance(
          balance: balance ?? this.balance,
          updatedAt: updatedAt ?? this.updatedAt,
          totalPoint: totalPoint ?? this.totalPoint);

  static num? _numFromJson(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
        balance: _numFromJson(json["balance"]),
        updatedAt: json["updated_at"]?.toString(),
        totalPoint: json["total_point"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "balance": balance,
        "updated_at": updatedAt,
        "total_point": totalPoint,
      };
}
