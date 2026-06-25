class Pagination<T> {
  final num? limit, page, totalRows;
  final String? sort;

  final List<T> data;

  Pagination(this.data, {this.limit, this.page, this.totalRows, this.sort});

  static num? _numFromJson(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  factory Pagination.fromJson(Map<String, dynamic> json, List<T> data) {
    return Pagination<T>(data,
        limit: _numFromJson(json["per_page"]),
        page: _numFromJson(json["current_page"]),
        totalRows: _numFromJson(json["total"]));
  }
}
