import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';

abstract class GameRepository {
  Future<GameState?> getSavedGame();
  Future<void> saveGame({required GameState gameState});
  Future<void> clearGame();
}
