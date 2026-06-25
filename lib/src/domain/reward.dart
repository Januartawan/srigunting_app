import 'dart:convert';

class Reward {
  final String? rewardCode;
  final String? name;
  final num? stok;
  final num? minPoint;
  final String? createdAt;
  final String? image;
  Reward({
    this.rewardCode,
    this.name,
    this.stok,
    this.minPoint,
    this.createdAt,
    this.image,
  });

  Reward copyWith({
    String? rewardCode,
    String? name,
    int? stok,
    int? minPoint,
    String? createdAt,
    String? image,
  }) =>
      Reward(
        rewardCode: rewardCode ?? this.rewardCode,
        name: name ?? this.name,
        stok: stok ?? this.stok,
        minPoint: minPoint ?? this.minPoint,
        createdAt: createdAt ?? this.createdAt,
        image: image ?? this.image,
      );

  Map<String, dynamic> toMap() {
    return {
      'rewardCode': rewardCode,
      'name': name,
      'stok': stok,
      'minPoint': minPoint,
      'createdAt': createdAt,
      'image': image,
    };
  }

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
        rewardCode: map['reward_code'],
        name: map['name'],
        stok: map['stok'],
        minPoint: map['min_point'],
        createdAt: map['created_at'],
        image: map['foto']);
  }

  String toJson() => json.encode(toMap());

  factory Reward.fromJson(String source) => Reward.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Reward(rewardCode: $rewardCode, name: $name, stok: $stok, minPoint: $minPoint, createdAt: $createdAt, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reward &&
        other.rewardCode == rewardCode &&
        other.name == name &&
        other.stok == stok &&
        other.minPoint == minPoint &&
        other.createdAt == createdAt &&
        other.image == image;
  }

  @override
  int get hashCode {
    return rewardCode.hashCode ^
        name.hashCode ^
        stok.hashCode ^
        minPoint.hashCode ^
        createdAt.hashCode ^
        image.hashCode;
  }
}
