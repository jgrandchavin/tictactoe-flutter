import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/make_move.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_state.dart';

part 'game_view_controller.g.dart';

@riverpod
class GameViewController extends _$GameViewController {
  @override
  GameViewState build(GameState? savedGame) {
    return GameViewState(gameState: savedGame ?? GameState.empty());
  }

  Future<void> makeMove({required Position position}) async {
    final gameState = state.gameState;
    final newGameState = await ref
        .read(makeMoveUsecaseProvider)
        .call(gameState: gameState, position: position);

    state = state.copyWith(gameState: newGameState);
  }

  Future<void> startNewGame() async {
    final newGameState = await ref.read(startNewGameUsecaseProvider).call();

    state = state.copyWith(gameState: newGameState);
  }
}
