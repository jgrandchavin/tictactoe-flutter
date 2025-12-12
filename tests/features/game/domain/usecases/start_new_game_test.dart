import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';

class _FakeGameRepository implements GameRepository {
  GameState? lastSavedGame;
  GameState? saved;

  @override
  Future<void> clearGame() async {
    saved = null;
    lastSavedGame = null;
  }

  @override
  Future<GameState?> getSavedGame() async => saved;

  @override
  Future<void> saveGame({required GameState gameState}) async {
    lastSavedGame = gameState;
    saved = gameState;
  }
}

void main() {
  setUpAll(() {
    // Silence logs during tests
    Logger.level = Level.off;
  });
  group('StartNewGame', () {
    test('creates an empty board, default state, and saves it', () async {
      final repo = _FakeGameRepository();
      final usecase = StartNewGame(gameRepository: repo);

      final result = await usecase();

      // Board is 3x3 and empty
      expect(result.board.cells.length, 3);
      expect(result.board.cells[0].length, 3);
      expect(
        result.board.cells.expand((r) => r).every((c) => c == null),
        isTrue,
      );

      // Defaults
      expect(result.status, GameStatus.notStarted);
      expect(result.currentPlayer, Player.x);
      expect(result.winner, isNull);

      // Saved
      expect(repo.lastSavedGame, isNotNull);
      final saved = repo.lastSavedGame!;
      expect(saved.status, GameStatus.notStarted);
      expect(saved.currentPlayer, Player.x);
      expect(
        saved.board.cells.expand((r) => r).every((c) => c == null),
        isTrue,
      );
    });
  });
}
