import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'start_new_game.g.dart';

class StartNewGame {
  final GameRepository gameRepository;

  StartNewGame({required this.gameRepository});

  Future<GameState> call() async {
    final gameState = GameState.empty();

    await gameRepository.saveGame(gameState: gameState);

    return gameState;
  }
}

@Riverpod(keepAlive: true)
StartNewGame startNewGameUsecase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return StartNewGame(gameRepository: gameRepository);
}
