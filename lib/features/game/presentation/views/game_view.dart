import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_button.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/board_widget.dart';

class GameView extends ConsumerWidget {
  final GameState? initialGameState;

  const GameView({super.key, this.initialGameState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      gameViewControllerProvider(initialGameState: initialGameState),
    );
    final controller = ref.read(
      gameViewControllerProvider(initialGameState: initialGameState).notifier,
    );

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AppButton(
                onPressed: () {
                  controller.startNewGame();
                },
                text: 'X',
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
