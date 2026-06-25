class FreeVisit {
  final String? status;
  final String? description;
  final String? note;
  final String? dateVisit;
  final String? adult;
  final String? child;
  final String? updatedAt;

  FreeVisit({
    this.status,
    this.description,
    this.note,
    this.dateVisit,
    this.adult,
    this.child,
    this.updatedAt,
  });

  FreeVisit copyWith(
          {String? status,
          String? description,
          String? note,
          String? dateVisit,
          String? adult,
          String? child,
          String? updatedAt}) =>
      FreeVisit(
        status: status ?? this.status,
        description: description ?? this.description,
        note: note ?? this.note,
        dateVisit: dateVisit ?? this.dateVisit,
        adult: adult ?? this.adult,
        child: child ?? this.child,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FreeVisit.fromMap(Map<String, dynamic> json) => FreeVisit(
        status: json["status"],
        description: json["description"],
        note: json["note"],
        dateVisit: json["date_visit"],
        adult: json["adult"].toString(),
        child: json["child"].toString(),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "description": description,
        "note": note,
        "date_visit": dateVisit,
        "adult": adult,
        "child": child,
        "updated_at": updatedAt,
      };
}
