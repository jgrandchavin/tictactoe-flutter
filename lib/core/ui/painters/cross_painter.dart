import 'package:flutter/material.dart';

/// Paints an "X" cross centered in the available canvas.
class CrossPainter extends CustomPainter {
  CrossPainter({
    this.color = const Color(0xFFF4A7D9),
    this.strokeWidth = 12.0,
    this.strokeCap = StrokeCap.round,
    this.sizeFactor = 0.85,
  });

  /// Cross color (defaults to a soft pink).
  final Color color;

  /// Thickness of each cross stroke.
  final double strokeWidth;

  /// Cap style at the ends of the strokes.
  final StrokeCap strokeCap;

  /// Scales the cross to be a fraction of the shortest side,
  /// helping match visual weight with the ring.
  ///
  final double sizeFactor;

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.shortestSide * sizeFactor.clamp(0.0, 1.0);
    if (side <= 0) return;

    // Inset so round caps don't get clipped at the edges.
    final double inset = strokeWidth / 2.0;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..strokeCap = strokeCap;

    // Draw within a centered square to ensure the cross is always square.
    final double dx = (size.width - side) / 2.0;
    final double dy = (size.height - side) / 2.0;
    final Rect square = Rect.fromLTWH(dx, dy, side, side);

    final Offset topLeft = Offset(square.left + inset, square.top + inset);
    final Offset topRight = Offset(square.right - inset, square.top + inset);
    final Offset bottomLeft = Offset(
      square.left + inset,
      square.bottom - inset,
    );
    final Offset bottomRight = Offset(
      square.right - inset,
      square.bottom - inset,
    );

    canvas.drawLine(topLeft, bottomRight, paint);
    canvas.drawLine(topRight, bottomLeft, paint);
  }

  @override
  bool shouldRepaint(covariant CrossPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.strokeCap != strokeCap;
  }
}
