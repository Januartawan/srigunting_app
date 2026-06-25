import 'package:flutter/material.dart';

class SDashedLine extends StatelessWidget {
  final Axis axis; // Horizontal atau vertical
  final double dashWidth;
  final double dashHeight;
  final double gap;
  final Color color;

  const SDashedLine({
    Key? key,
    this.axis = Axis.horizontal,
    this.dashWidth = 10.0,
    this.dashHeight = 2.0,
    this.gap = 5.0,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: axis == Axis.horizontal
          ? Size(double.infinity, dashHeight)
          : Size(dashWidth, double.infinity),
      painter: DashedLinePainter(
        axis: axis,
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        gap: gap,
        color: color,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Axis axis;
  final double dashWidth;
  final double dashHeight;
  final double gap;
  final Color color;

  DashedLinePainter({
    required this.axis,
    required this.dashWidth,
    required this.dashHeight,
    required this.gap,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashHeight
      ..style = PaintingStyle.stroke;

    double start = 0.0;

    if (axis == Axis.horizontal) {
      while (start < size.width) {
        canvas.drawLine(
          Offset(start, size.height / 2),
          Offset(start + dashWidth, size.height / 2),
          paint,
        );
        start += dashWidth + gap;
      }
    } else {
      while (start < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, start),
          Offset(size.width / 2, start + dashHeight),
          paint,
        );
        start += dashHeight + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
