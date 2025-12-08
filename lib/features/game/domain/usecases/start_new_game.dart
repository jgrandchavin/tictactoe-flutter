import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

class StartNewGame {
  final GameRepository gameRepository;

  StartNewGame({required this.gameRepository});

  Future<void> call() async {
    final gameState = GameState.empty();

    return gameRepository.saveGame(gameState: gameState);
  }
}
