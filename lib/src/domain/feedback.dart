class Feedback {
  final String? ratingSusuk;
  final String? messageSusuk;
  final String? ratingPelayanan;
  final String? messagePelayanan;
  final String? ratingOther;
  final String? messageOther;
  final String? createdAt;

  Feedback({
    this.ratingSusuk,
    this.messageSusuk,
    this.ratingPelayanan,
    this.messagePelayanan,
    this.ratingOther,
    this.messageOther,
    this.createdAt,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        ratingSusuk: json["rating_susuk"]?.toString(),
        messageSusuk: json["message_susuk"]?.toString(),
        ratingPelayanan: json["rating_pelayanan"]?.toString(),
        messagePelayanan: json["message_pelayanan"]?.toString(),
        ratingOther: json["rating_other"]?.toString(),
        messageOther: json["message_other"]?.toString(),
        createdAt: json["created_at"]?.toString(),
      );

  /// Payload for the feedback-store endpoint (created_at is not sent).
  Map<String, dynamic> toStoreJson() => {
        "rating_susuk": ratingSusuk,
        "message_susuk": messageSusuk,
        "rating_pelayanan": ratingPelayanan,
        "message_pelayanan": messagePelayanan,
        "rating_other": ratingOther,
        "message_other": messageOther,
      };

  /// Whether the user has previously submitted feedback.
  bool get hasSubmitted => createdAt != null && createdAt!.trim().isNotEmpty;
}
