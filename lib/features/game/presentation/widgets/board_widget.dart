import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/ui/app_colors.dart';
import 'package:tictactoe_flutter/core/ui/painters/cross_painter.dart';
import 'package:tictactoe_flutter/core/ui/painters/ring_painter.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_text.dart';
import 'package:tictactoe_flutter/core/ui/widgets/custom_gesture_detector.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/board_cell_widget.dart';

class BoardWidget extends ConsumerWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameViewControllerProvider);
    final controller = ref.read(gameViewControllerProvider.notifier);
    final cells = state.gameState.board.cells;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.tertiary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: RepaintBoundary(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Board.size,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: Board.size * Board.size,
                    itemBuilder: (context, index) {
                      final row = index ~/ Board.size;
                      final col = index % Board.size;
                      final player = cells[row][col];

                      return CustomGestureDetector(
                        onTap: () {
                          controller.makeMove(
                            position: Position(row: row, column: col),
                          );
                        },
                        child: BoardCellWidget(
                          cellIndex: index,
                          player: player,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
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
              child: state.gameState.winner == null
                  ? Row(
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
                    )
                  : Row(
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
                    ),
            ),
          ],
        ),
        Positioned(bottom: 48, left: 32, child: _SmallBoardClip()),
        Positioned(bottom: 48, right: 32, child: _SmallBoardClip()),
      ],
    );
  }
}

class _SmallBoardClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 16,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.tertiary,
            blurRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}
