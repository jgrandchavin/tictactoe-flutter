import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;

  const AppLoader({
    super.key,
    this.size = 40,
    this.strokeWidth = 4,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color foreground = color ?? Theme.of(context).colorScheme.primary;
    final Color bg = backgroundColor ?? foreground.withValues(alpha: 0.2);

    return Semantics(
      label: 'Loading',
      child: SizedBox(
        height: size,
        width: size,
        child: LoopAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutCubic,
          builder: (context, t, _) {
            final double sweep = (2 * math.pi) * t;
            // Smoothly fade in at start and fade out at end to avoid visible jump.
            final double opacity = () {
              const double fadePortion = 0.08; // 8% at start/end for fade
              if (t < fadePortion) {
                // fade-in
                return Curves.easeIn.transform(t / fadePortion);
              }
              if (t > 1 - fadePortion) {
                // fade-out
                return Curves.easeOut.transform(
                  1 - (t - (1 - fadePortion)) / fadePortion,
                );
              }
              return 1.0;
            }();
            return CustomPaint(
              painter: _ArcSpinnerPainter(
                color: foreground.withValues(alpha: opacity.clamp(0.0, 1.0)),
                backgroundColor: bg,
                strokeWidth: strokeWidth,
                sweep: sweep,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArcSpinnerPainter extends CustomPainter {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double sweep;

  _ArcSpinnerPainter({
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.sweep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final double inset = strokeWidth / 2;
    final Rect arcRect = Rect.fromLTWH(
      rect.left + inset,
      rect.top + inset,
      rect.width - strokeWidth,
      rect.height - strokeWidth,
    );

    final Paint bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = backgroundColor;
    final Paint fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Background ring
    canvas.drawArc(arcRect, 0, 2 * math.pi, false, bgPaint);

    // Foreground arc: start at the top and fill based on animation progress.
    const double startAngle = -math.pi / 2;
    canvas.drawArc(
      arcRect,
      startAngle,
      sweep.clamp(0, 2 * math.pi),
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcSpinnerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.sweep != sweep;
  }
}
