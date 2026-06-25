import 'package:flutter/material.dart';

class SImageAsset extends StatelessWidget {
  final String fileName;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const SImageAsset(
      {super.key, required this.fileName, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$fileName',
      width: width,
      height: height,
      fit: fit,
    );
  }
}
