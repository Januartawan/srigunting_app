import 'package:flutter/material.dart';

class SImageDecoration extends StatefulWidget {
  final double? height;
  final double? width;
  final ImageProvider image;

  const SImageDecoration(
      {super.key, this.height, this.width, required this.image});

  @override
  State<SImageDecoration> createState() => _SImageDecorationState();
}

class _SImageDecorationState extends State<SImageDecoration> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
