import 'package:tictactoe_flutter/features/game/data/datasources/game_local_datasource.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_state_model.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource gameLocalDataSource;

  GameRepositoryImpl({required this.gameLocalDataSource});

  @override
  Future<void> clearGame() async {
    await gameLocalDataSource.clearGame();
  }

  @override
  Future<GameState?> getSavedGame() async {
    final gameState = await gameLocalDataSource.getSavedGame();
    return gameState.toDomain();
  }

  @override
  Future<void> saveGame({required GameState gameState}) async {
    await gameLocalDataSource.saveGame(
      gameState: GameStateModel.fromDomain(gameState),
    );
  }
}
