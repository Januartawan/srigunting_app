import 'dart:async';

import 'package:flutter/material.dart';

class Device {
  final String? name, model, version;

  Device({required this.name, this.model, this.version});

  Map<String, dynamic> toJson() {
    return {"name": name, "model": model, "version": version};
  }
}

Device? activeDevice;

StreamController<bool> loadingStreamController = StreamController<bool>();
StreamController<double> loadingProgressStreamController =
    StreamController<double>();

// var storage = SecureStorage();
