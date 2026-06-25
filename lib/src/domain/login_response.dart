class Data {
  String? token;

  Data({
    this.token,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}

class LoginResponse {
  final num? status;
  final Data? data;
  final String? message;

  LoginResponse({this.status, this.data, this.message});

  LoginResponse copyWith({
    int? status,
    String? message,
    Data? data,
  }) =>
      LoginResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );
}
