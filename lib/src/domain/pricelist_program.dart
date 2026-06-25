class PricelistProgram {
  final String? title;
  final String? media;
  final String? foto;

  PricelistProgram({this.title, this.media, this.foto});

  factory PricelistProgram.fromJson(Map<String, dynamic> json) =>
      PricelistProgram(
        title: json["title"],
        media: json["media"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "media": media,
        "foto": foto,
      };
}
