import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'get_saved_game.g.dart';

class GetSavedGame {
  final GameRepository gameRepository;

  GetSavedGame({required this.gameRepository});

  Future<GameState?> call() async {
    return await gameRepository.getSavedGame();
  }
}

@Riverpod(keepAlive: true)
GetSavedGame getSavedGameUsecase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return GetSavedGame(gameRepository: gameRepository);
}
