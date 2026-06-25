class PaginationRequest {
  final num? page, perPage;

  PaginationRequest({this.page, this.perPage});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }
}
