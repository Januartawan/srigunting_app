class PointHistoryStatus {
  static const pointIn = 'Point In';
  static const pointOut = 'Point Out';
  static const pointInLabel = 'Poin Masuk';
  static const pointOutLabel = 'Poin Keluar';

  static String displayLabel(String? status, {String fallback = ''}) {
    if (status == pointIn) return pointInLabel;
    if (status == pointOut) return pointOutLabel;
    return status ?? fallback;
  }
}
