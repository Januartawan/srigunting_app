import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SImageSvgAsset extends StatelessWidget {
  final String fileName;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;

  const SImageSvgAsset({
    super.key,
    required this.fileName,
    this.height,
    this.width,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$fileName',
      height: height,
      width: width,
      colorFilter: colorFilter,
    );
  }
}
