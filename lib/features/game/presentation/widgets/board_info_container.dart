import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/ui/app_colors.dart';
import 'package:tictactoe_flutter/core/ui/painters/cross_painter.dart';
import 'package:tictactoe_flutter/core/ui/painters/ring_painter.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';

class BoardInfoContainer extends ConsumerWidget {
  const BoardInfoContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameViewControllerProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.tertiary,
            blurRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Builder(
        builder: (context) {
          if (state.gameState.status == GameStatus.notStarted ||
              state.gameState.status == GameStatus.inProgress) {
            return Row(
              key: ValueKey<Player>(state.gameState.currentPlayer),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.gameState.currentPlayer == Player.x)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomPaint(
                      painter: CrossPainter(
                        color: AppColors.blue,
                        strokeWidth: 4,
                      ),
                    ),
                  )
                else if (state.gameState.currentPlayer == Player.o)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomPaint(
                      painter: RingPainter(
                        color: AppColors.pink,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                AppText.custom(
                  text:
                      '${state.gameState.currentPlayer == Player.x ? 'Cross' : 'Circle'}'
                          .toUpperCase(),
                  textAlign: TextAlign.center,
                  color: state.gameState.currentPlayer == Player.x
                      ? AppColors.blue
                      : AppColors.pink,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
                const SizedBox(width: 4),
                AppText.custom(
                  text: 'Turn'.toUpperCase(),
                  textAlign: TextAlign.center,
                  color: AppColors.white,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
              ],
            );
          } else if (state.gameState.winner != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.gameState.winner == Player.x)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomPaint(
                      painter: CrossPainter(
                        color: AppColors.blue,
                        strokeWidth: 4,
                      ),
                    ),
                  )
                else if (state.gameState.winner == Player.o)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomPaint(
                      painter: RingPainter(
                        color: AppColors.pink,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                AppText.custom(
                  text: 'Wins!'.toUpperCase(),
                  textAlign: TextAlign.center,
                  color: AppColors.white,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                ),
              ],
            );
          } else {
            return AppText.custom(
              text: 'No body wins...'.toUpperCase(),
              textAlign: TextAlign.center,
              color: AppColors.white,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontStyle: FontStyle.normal,
            );
          }
        },
      ),
    );
  }
}
