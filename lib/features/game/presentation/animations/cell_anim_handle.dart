import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellAnimHandle {
  final VoidCallback appear;
  final VoidCallback tap;
  final VoidCallback tapError;
  final void Function({bool repeat}) win;
  final VoidCallback stopWin;
  final void Function(Offset delta, {Duration? duration}) nudge;

  const CellAnimHandle({
    required this.appear,
    required this.tap,
    required this.tapError,
    required this.win,
    required this.stopWin,
    required this.nudge,
  });
}

final cellAnimHandleProvider =
    Provider.family<ValueNotifier<CellAnimHandle?>, int>((ref, cellIndex) {
      final notifier = ValueNotifier<CellAnimHandle?>(null);
      ref.onDispose(notifier.dispose);
      return notifier;
    });
