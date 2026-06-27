import 'package:intl/intl.dart';

extension DateParser on DateTime {
  String? parseDateString({String? pattern}) {
    return DateFormat(pattern ?? 'dd-MM-yyyy').format(this);
  }

  String siso8601WithOffset() {
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String formatted = formatter.format(this);

    // Hitung offset zona waktu
    Duration offset = timeZoneOffset;
    String hours = offset.inHours.abs().toString().padLeft(2, '0');
    String minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    String sign = offset.isNegative ? "-" : "+";

    return "$formatted$sign$hours:$minutes";
  }

  String? parseTimeString(
      {String? pattern, bool utc = false, bool toLocal = false}) {
    var time = this;
    if (utc) {
      time = time.toUtc();
    } else if (toLocal) {
      time = time.toLocal();
    }
    return DateFormat(pattern ?? 'HH:mm aa').format(time);
  }

  static DateTime? fromDateString(String dateString, {String? pattern}) {
    try {
      return DateFormat(pattern ?? 'dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return null; // Handle parsing error if needed
    }
  }

  static DateTime? fromTimeString(String timeString, {String? pattern}) {
    try {
      return DateFormat(pattern ?? 'HH:mm').parse(timeString);
    } catch (e) {
      return null; // Handle parsing error if needed
    }
  }
}

extension DateParserNullable on DateTime? {
  String parseDateString({String? pattern}) {
    if (this == null) {
      return "";
    } else {
      return DateFormat(pattern ?? 'dd-MM-yyyy').format(this ?? DateTime.now());
    }
  }

  String parseDateTimeString({String? pattern}) {
    if (this == null) {
      return "";
    } else {
      return DateFormat(pattern ?? 'dd-MM-yyyy H:mm a')
          .format(this ?? DateTime.now());
    }
  }

  String parseTimeString({String? pattern, bool utc = false}) {
    var time = this ?? DateTime.now();
    if (utc) {
      time = time.toUtc();
    }
    return DateFormat(pattern ?? 'HH:mm aa').format(time);
  }

  static DateTime? fromNullableDateString(String dateString,
      {String? pattern}) {
    try {
      return DateFormat(pattern ?? 'dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return DateTime.now(); // Fallback to current time if parsing fails
    }
  }

  static DateTime? fromNullableTimeString(String timeString,
      {String? pattern}) {
    try {
      return DateFormat(pattern ?? 'HH:mm').parse(timeString);
    } catch (e) {
      return DateTime.now(); // Fallback to current time if parsing fails
    }
  }
}

extension StringToDateTime on String {
  DateTime? toDateTime({String? pattern}) {
    try {
      return DateFormat(pattern ?? 'dd-MM-yyyy').parse(this);
    } catch (e) {
      return null; // Handle parsing error if needed
    }
  }

  DateTime? toTime({String? pattern}) {
    try {
      return DateFormat(pattern ?? 'HH:mm').parse(this);
    } catch (e) {
      return null; // Handle parsing error if needed
    }
  }
}

extension StringToDateTimeNullable on String? {
  DateTime? toDateTime({String? pattern}) {
    if (this == null) {
      return DateTime.now(); // Default to now if string is null
    }
    try {
      return DateFormat(pattern ?? 'dd-MM-yyyy').parse(this!);
    } catch (e) {
      return DateTime.now(); // Handle parsing error and default to now
    }
  }

  DateTime? toTime({String? pattern}) {
    if (this == null) {
      return DateTime.now(); // Default to now if string is null
    }
    try {
      return DateFormat(pattern ?? 'HH:mm').parse(this!);
    } catch (e) {
      return DateTime.now(); // Handle parsing error and default to now
    }
  }
}
