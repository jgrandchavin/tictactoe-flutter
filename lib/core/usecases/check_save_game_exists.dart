import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'check_save_game_exists.g.dart';

class CheckSavedGameExists {
  final GameRepository gameRepository;

  CheckSavedGameExists({required this.gameRepository});

  Future<bool> call() async {
    final savedGame = await gameRepository.getSavedGame();
    return savedGame != null && savedGame.status == GameStatus.inProgress;
  }
}

@Riverpod(keepAlive: true)
CheckSavedGameExists checkSavedGameExistsUsecase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return CheckSavedGameExists(gameRepository: gameRepository);
}
