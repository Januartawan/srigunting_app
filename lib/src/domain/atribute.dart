import 'dart:convert';

class Atribute {
  final String id;
  final String name;
  Atribute({
    required this.id,
    required this.name,
  });

  Atribute copyWith({
    String? id,
    String? name,
  }) {
    return Atribute(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Atribute.fromMap(Map<String, dynamic> map) {
    return Atribute(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Atribute.fromJson(String source) =>
      Atribute.fromMap(json.decode(source));

  @override
  String toString() => 'Atribute(ID: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Atribute && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
