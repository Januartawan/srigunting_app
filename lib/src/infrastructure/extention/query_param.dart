extension QueryParam on String {
  String queryParam(Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) return this;

    final uri = Uri.parse(this);

    // Gunakan queryParametersAll agar lebih fleksibel
    final newUri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      ...params.map((key, value) => MapEntry(key, value.toString())),
    });

    return newUri.toString();
  }
}
