import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

class GetSavedGame {
  final GameRepository gameRepository;

  GetSavedGame({required this.gameRepository});

  Future<GameState?> call() async {
    return await gameRepository.getSavedGame();
  }
}
