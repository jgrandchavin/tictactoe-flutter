import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';
import 'package:tictactoe_flutter/core/design/painters/cross_painter.dart';
import 'package:tictactoe_flutter/core/design/painters/ring_painter.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class BoardCellWidget extends StatelessWidget {
  final int cellIndex;
  final Player? player;

  const BoardCellWidget({
    super.key,
    required this.cellIndex,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: _cellContent(player),
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
            text: '${cellIndex + 1}',
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
