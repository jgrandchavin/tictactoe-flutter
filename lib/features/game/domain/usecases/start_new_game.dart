import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/utils/logger.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'start_new_game.g.dart';

class StartNewGame {
  final GameRepository gameRepository;

  StartNewGame({required this.gameRepository});

  Future<GameState> call() async {
    var gameState = GameState();
    gameState = gameState.copyWith(board: Board.empty());

    await gameRepository.saveGame(gameState: gameState);

    log.d('[START_NEW_GAME] Started new game');

    return gameState;
  }
}

@Riverpod(keepAlive: true)
StartNewGame startNewGameUsecase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return StartNewGame(gameRepository: gameRepository);
}
