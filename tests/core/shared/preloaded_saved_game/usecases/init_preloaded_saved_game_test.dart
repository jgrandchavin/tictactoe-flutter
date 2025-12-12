import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/usecases/init_preloaded_saved_game.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

class _FakeGameRepository implements GameRepository {
  GameState? toReturn;
  GameState? lastSavedGame;

  @override
  Future<void> clearGame() async {}

  @override
  Future<GameState?> getSavedGame() async => toReturn;

  @override
  Future<void> saveGame({required GameState gameState}) async {
    lastSavedGame = gameState;
  }
}

void main() {
  setUpAll(() {
    Logger.level = Level.off;
  });

  group('InitPreloadedSavedGame', () {
    test('returns null and sets state to null when no saved game', () async {
      final repo = _FakeGameRepository()..toReturn = null;
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final preloaded = container.read(preloadedSavedGameStateProvider.notifier)
        ..set(null);
      final usecase = InitPreloadedSavedGame(
        gameRepository: repo,
        preloadedSavedGameState: preloaded,
      );

      final result = await usecase();

      expect(result, isNull);
      expect(preloaded.get(), isNull);
    });

    test(
      'maps domain game to PreloadedSavedGameInfo and stores in state',
      () async {
        final board = Board.empty();
        board.cells[0][0] = Player.x;
        board.cells[0][1] = Player.o;
        board.cells[1][1] = Player.x;

        final domain = GameState(
          board: board,
          status: GameStatus.inProgress,
          currentPlayer: Player.o,
          winner: null,
        );

        final repo = _FakeGameRepository()..toReturn = domain;
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final preloaded = container.read(
          preloadedSavedGameStateProvider.notifier,
        )..set(null);
        final usecase = InitPreloadedSavedGame(
          gameRepository: repo,
          preloadedSavedGameState: preloaded,
        );

        final result = await usecase();

        expect(result, isNotNull);
        final PreloadedSavedGameInfo info = result!;
        expect(info.status, 'inProgress');
        expect(info.currentPlayer, 2); // Player.o
        expect(info.winner, isNull);
        expect(info.board[0][0], 1); // X -> 1
        expect(info.board[0][1], 2); // O -> 2
        expect(info.board[1][1], 1); // X -> 1
        // stored in state
        final stored = preloaded.get()!;
        expect(stored.status, 'inProgress');
        expect(stored.currentPlayer, 2);
      },
    );

    test('maps finished game with winner', () async {
      final board = Board.empty();
      board.cells[2][0] = Player.x;
      board.cells[2][1] = Player.x;
      board.cells[2][2] = Player.x;
      final domain = GameState(
        board: board,
        status: GameStatus.finished,
        currentPlayer: Player.o,
        winner: Player.x,
      );
      final repo = _FakeGameRepository()..toReturn = domain;
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final preloaded = container.read(preloadedSavedGameStateProvider.notifier)
        ..set(null);
      final usecase = InitPreloadedSavedGame(
        gameRepository: repo,
        preloadedSavedGameState: preloaded,
      );

      final result = await usecase();

      expect(result, isNotNull);
      expect(result!.status, 'finished');
      expect(result.winner, 1); // X winner -> 1
    });
  });
}
