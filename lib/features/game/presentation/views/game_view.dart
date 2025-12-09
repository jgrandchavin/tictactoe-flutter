import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/board_widget.dart';

class GameView extends ConsumerWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameViewControllerProvider);
    final controller = ref.read(gameViewControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.gameState.status.name),
            Text(state.gameState.winner?.name ?? ''),
            BoardWidget(
              board: state.gameState.board,
              onCellTap: (position) {
                controller.makeMove(position: position);
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.startNewGame();
              },
              child: const Text('Start New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
