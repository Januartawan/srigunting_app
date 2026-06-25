import 'package:intl/intl.dart';

class RegisterRequest {
  final num? id;
  final num? nik;
  final String? name;
  // Stored as String so a leading "0" (e.g. 0812...) is preserved.
  final String? phoneNumber;
  final num? birthPlace;
  final DateTime? birthDate;
  final String? address;
  final String? gender;
  final String? religion;
  final String? marital;
  final num? areaPangkalan;
  final String? email;
  final String? username;
  final String? password;
  final String? cPassword;

  RegisterRequest({
    this.id,
    this.nik,
    this.name,
    this.phoneNumber,
    this.birthPlace,
    this.birthDate,
    this.address,
    this.gender,
    this.religion,
    this.marital,
    this.areaPangkalan,
    this.email,
    this.username,
    this.password,
    this.cPassword,
  });

  RegisterRequest copyWith({
    num? id,
    num? nik,
    String? name,
    String? phoneNumber,
    String? address,
    int? birthPlace,
    DateTime? birthDate,
    String? gender,
    String? religion,
    String? marital,
    int? areaPangkalan,
    String? email,
    String? username,
    String? password,
    String? cPassword,
  }) =>
      RegisterRequest(
        id: id ?? this.id,
        nik: nik ?? this.nik,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        birthPlace: birthPlace ?? this.birthPlace,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        religion: religion ?? this.religion,
        marital: marital ?? this.marital,
        areaPangkalan: areaPangkalan ?? this.areaPangkalan,
        email: email ?? this.email,
        username: username ?? this.username,
        password: password ?? this.password,
        cPassword: cPassword ?? this.cPassword,
      );

  factory RegisterRequest.fromMap(Map<String, dynamic> json) => RegisterRequest(
        id: json["id"],
        nik: json["nik"],
        name: json["name"],
        phoneNumber: json["phonenumber"],
        address: json["address"],
        birthPlace: json["birth_place"],
        birthDate: DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        religion: json["religion"],
        marital: json["marital"],
        areaPangkalan: json["area_pangkalan"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        cPassword: json["c_password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nik": nik,
        "name": name,
        "phonenumber": phoneNumber,
        "address": address,
        "birth_place": birthPlace,
        "birth_date": birthDate != null
            ? DateFormat('yyyy-MM-dd').format(birthDate!)
            : null,
        "gender": gender,
        "religion": religion,
        "marital": marital,
        "area_pangkalan": areaPangkalan,
        "email": email,
        "username": username,
        "password": password,
        "c_password": cPassword,
      };
}
