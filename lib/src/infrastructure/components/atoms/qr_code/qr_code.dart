import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SQRCode extends StatelessWidget {
  final String data;
  final double size;

  const SQRCode({super.key, required this.data, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: size,
    );
  }
}
