import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/app_router.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_button.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/board_widget.dart';

class GameView extends ConsumerWidget {
  final GameState? savedGame;

  const GameView({super.key, required this.savedGame});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameViewControllerProvider(savedGame));
    final controller = ref.read(gameViewControllerProvider(savedGame).notifier);

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            BoardWidget(
              board: state.gameState.board,
              winner: state.gameState.winner,
              currentPlayer: state.gameState.currentPlayer,
              onCellTap: (position) {
                controller.makeMove(position: position);
              },
            ),
            Spacer(),
            const SizedBox(height: 32),
            AppButton(
              onPressed: () {
                controller.startNewGame();
              },
              text: 'Start New Game',
            ),
            const SizedBox(height: 8),
            AppButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRouter.menuRoute,
                  arguments: state.gameState.status != GameStatus.finished
                      ? state.gameState
                      : null,
                );
              },
              text: 'Return to Menu',
            ),
          ],
        ),
      ),
    );
  }
}
