class Information {
  final String? slug;
  final String? name;
  final String? photo;
  final String? description;
  final String? dateStart;
  final String? date;

  Information(
      {this.slug,
      this.name,
      this.photo,
      this.description,
      this.dateStart,
      this.date});

  Information copyWith(
          {String? slug,
          String? name,
          String? photo,
          String? description,
          String? dateStart,
          String? date}) =>
      Information(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        description: description ?? this.description,
        dateStart: dateStart ?? this.dateStart,
        date: date ?? this.date,
      );

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        slug: json["slug"],
        name: json["name"],
        photo: json["foto"],
        description: json["description"],
        dateStart: json["date_start"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "foto": photo,
        "description": description,
        "date_start": dateStart,
        "date": date,
      };
}
