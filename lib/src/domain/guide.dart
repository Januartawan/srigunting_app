import 'package:srigunting_app/src/infrastructure/extention/date.dart';

class Guide {
  final int? id;
  final String? guideCode;
  final String? segment;
  final String? name;
  final String? phonenumber;
  final String? email;
  final int? nik;
  final String? address;
  final String? birthPlace;
  final DateTime? birthDate;
  final String? gender;
  final String? religion;
  final String? marital;
  final String? areaPangkalan;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? username;

  Guide({
    this.id,
    this.guideCode,
    this.segment,
    this.name,
    this.phonenumber,
    this.email,
    this.nik,
    this.address,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.religion,
    this.marital,
    this.areaPangkalan,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.username,
  });

  Guide copyWith({
    int? id,
    String? guideCode,
    String? segment,
    String? name,
    String? phonenumber,
    String? email,
    int? nik,
    String? address,
    String? birthPlace,
    DateTime? birthDate,
    String? gender,
    String? religion,
    String? marital,
    String? areaPangkalan,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
  }) =>
      Guide(
        id: id ?? this.id,
        guideCode: guideCode ?? this.guideCode,
        segment: segment ?? this.segment,
        name: name ?? this.name,
        phonenumber: phonenumber ?? this.phonenumber,
        email: email ?? this.email,
        nik: nik ?? this.nik,
        address: address ?? this.address,
        birthPlace: birthPlace ?? this.birthPlace,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        religion: religion ?? this.religion,
        marital: marital ?? this.marital,
        areaPangkalan: areaPangkalan ?? this.areaPangkalan,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
      );

  factory Guide.fromMap(Map<String, dynamic> json) => Guide(
        id: json["id"],
        guideCode: json["guide_code"],
        segment: json["segment"],
        name: json["name"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        nik: json["nik"],
        address: json["address"],
        birthPlace: json["birth_place"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        religion: json["religion"],
        marital: json["marital"],
        areaPangkalan: json["area_pangkalan"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "guide_code": guideCode,
        "segment": segment,
        "name": name,
        "phonenumber": phonenumber,
        "email": email,
        "nik": nik,
        "address": address,
        "birth_place": birthPlace,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "religion": religion,
        "marital": marital,
        "area_pangkalan": areaPangkalan,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "username": username,
      };

  /// Returns birthDate as formatted string (dd-MM-yyyy) or empty if null
  String get birthDateFormatted => birthDate?.parseDateString() ?? '';
}
