class FreeTicketRequest {
  final String? child;
  final String? adult;
  final String? date;

  FreeTicketRequest({this.adult, this.child, this.date});

  Map<String, dynamic> toMap() => {
        "child": child,
        "adult": adult,
        "date_visit": date,
      };
}
