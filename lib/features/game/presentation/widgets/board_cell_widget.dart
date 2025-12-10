import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';
import 'package:tictactoe_flutter/core/design/painters/cross_painter.dart';
import 'package:tictactoe_flutter/core/design/painters/ring_painter.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/presentation/animation/cell_anim_handle.dart';

class BoardCellWidget extends ConsumerStatefulWidget {
  final int cellIndex;
  final Player? player;

  const BoardCellWidget({
    super.key,
    required this.cellIndex,
    required this.player,
  });

  @override
  ConsumerState<BoardCellWidget> createState() => _BoardCellWidgetState();
}

class _BoardCellWidgetState extends ConsumerState<BoardCellWidget>
    with TickerProviderStateMixin {
  late final ValueNotifier<CellAnimHandle?> _handleNotifier;
  late final AnimationController _appearCtrl;
  late final AnimationController _tapCtrl;
  late final AnimationController _errorCtrl;
  late final AnimationController _winCtrl;
  late final AnimationController _nudgeCtrl;

  late final Animation<double> _appearScale;
  late final Animation<double> _tapScale;
  late final Animation<Offset> _errorOffset;
  late final Animation<double> _winOpacity;
  Animation<Offset>? _nudgeOffset;
  late final Animation<double> _winScale;

  @override
  void initState() {
    super.initState();
    _handleNotifier = ref.read(cellAnimHandleProvider(widget.cellIndex));
    _appearCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _tapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    _errorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _winCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _nudgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );

    _appearScale = Tween(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _appearCtrl, curve: Curves.easeOutCubic));
    _tapScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.92), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _tapCtrl, curve: Curves.easeOut));
    _errorOffset = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(-0.06, 0)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(-0.06, 0), end: const Offset(0.06, 0)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0.06, 0), end: Offset.zero),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(parent: _errorCtrl, curve: Curves.ease));
    _winOpacity = Tween(
      begin: 0.0,
      end: 0.35,
    ).animate(CurvedAnimation(parent: _winCtrl, curve: Curves.easeInOut));
    _winScale = Tween(
      begin: 1.0,
      end: 1.06,
    ).animate(CurvedAnimation(parent: _winCtrl, curve: Curves.easeInOut));

    // Register handle for controller to command this cell
    _handleNotifier.value = CellAnimHandle(
      appear: () => _appearCtrl.forward(from: 0),
      tap: () => _tapCtrl.forward(from: 0),
      tapError: () => _errorCtrl.forward(from: 0),
      win: ({bool repeat = true}) =>
          repeat ? _winCtrl.repeat(reverse: true) : _winCtrl.forward(from: 0),
      stopWin: () {
        _winCtrl.stop();
        _winCtrl.value = 0.0;
      },
      nudge: (delta, {duration}) {
        _nudgeCtrl.duration = duration ?? const Duration(milliseconds: 300);
        _nudgeOffset = TweenSequence<Offset>([
          TweenSequenceItem(
            tween: Tween(begin: Offset.zero, end: delta),
            weight: 100,
          ),
          TweenSequenceItem(
            tween: Tween(begin: delta, end: Offset.zero),
            weight: 100,
          ),
        ]).animate(CurvedAnimation(parent: _nudgeCtrl, curve: Curves.easeOut));
        _nudgeCtrl.forward(from: 0);
        setState(() {});
      },
    );
    // Note: we'll unregister in dispose to avoid WidgetRef.onDispose (not available)

    // Initial appear
    _appearCtrl.forward();
  }

  @override
  void dispose() {
    // Unregister handle without using ref in dispose
    _handleNotifier.value = null;
    _appearCtrl.dispose();
    _tapCtrl.dispose();
    _errorCtrl.dispose();
    _winCtrl.dispose();
    _nudgeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = _cellContent(widget.player);
    return SlideTransition(
      position: _errorOffset,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _appearCtrl,
          _tapCtrl,
          _nudgeCtrl,
          _winCtrl,
        ]),
        builder: (context, _) {
          final scale = _appearScale.value * _tapScale.value * _winScale.value;
          return Transform.scale(
            scale: scale,
            child: Transform.translate(
              offset: _nudgeOffset?.value ?? Offset.zero,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary,
                          blurRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: child,
                  ),
                  // Win pulse overlay
                  FadeTransition(
                    opacity: _winOpacity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _cellContent(Player? player) {
    switch (player) {
      case Player.x:
        return SizedBox.expand(
          child: CustomPaint(
            painter: CrossPainter(color: AppColors.blue, strokeWidth: 12),
          ),
        );
      case Player.o:
        return SizedBox.expand(
          child: CustomPaint(painter: RingPainter(color: AppColors.pink)),
        );
      case null:
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: AppText.custom(
            text: '${widget.cellIndex + 1}',
            textAlign: TextAlign.center,
            color: AppColors.white.withValues(alpha: 0.05),
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w900,
            fontSize: 100,
            fontStyle: FontStyle.normal,
          ),
        );
    }
  }
}
