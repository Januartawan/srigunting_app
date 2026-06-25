import 'dart:developer';

import 'package:logging/logging.dart';

void logInfo(String key, dynamic data) {
  Logger(key).info(data);
  log("$data", name: key);
}

void logError(String key, dynamic data) {
  Logger("onResponse").info("Headers:");
  log("$data", name: key);
}
