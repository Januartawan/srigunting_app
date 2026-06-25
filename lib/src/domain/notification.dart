class NotificationApp {
  final String? slug;
  final String? name;
  final String? description;
  final String? date;
  final num? read;

  NotificationApp(
      {this.slug, this.name, this.description, this.date, this.read});

  // Getter untuk mengkonversi read dari integer ke boolean
  bool get isRead {
    if (read == null) {
      return false;
    }
    if (read is bool) {
      return read as bool;
    }
    if (read is num) {
      return read == 1;
    }
    return false;
  }

  NotificationApp copyWith({
    String? slug,
    String? name,
    String? description,
    String? date,
    num? read,
  }) =>
      NotificationApp(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        description: description ?? this.description,
        date: date ?? this.date,
        read: read ?? this.read,
      );

  static num? _numFromJson(dynamic value) {
    if (value is num) return value;
    if (value is bool) return value ? 1 : 0;
    if (value is String) return num.tryParse(value);
    return null;
  }

  factory NotificationApp.fromJson(Map<String, dynamic> json) =>
      NotificationApp(
        slug: json["slug"],
        name: json["name"],
        description: json["description"],
        date: json["date"],
        read: _numFromJson(json["read"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "description": description,
        "date": date,
        "read": read,
      };
}
