import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SShimmerList extends StatelessWidget {
  final double? height;
  final double? width;

  const SShimmerList({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width ?? 200,
        height: height ?? 20,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
