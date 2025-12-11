import 'package:flutter/material.dart';

/// Paints a ring (donut) centered in the available canvas.
class RingPainter extends CustomPainter {
  RingPainter({
    this.color = const Color(0xFFF4A7D9),
    this.strokeWidth = 12.0,
    this.strokeCap = StrokeCap.round,
  });

  /// Ring color (defaults to a soft pink).
  final Color color;

  /// Thickness of the ring.
  final double strokeWidth;

  /// Cap style at the edges of the stroke.
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final double minSide = size.shortestSide;
    if (minSide <= 0) return;

    final Offset center = size.center(Offset.zero);
    final double radius = (minSide - strokeWidth) / 2.0;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..strokeCap = strokeCap;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.strokeCap != strokeCap;
  }
}
