import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:tictactoe_flutter/core/errors/game_error.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/make_move.dart';

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
  group('MakeMove', () {
    test(
      'makes a valid move, toggles player, sets inProgress, and saves',
      () async {
        final repo = _FakeGameRepository();
        final usecase = MakeMove(gameRepository: repo);
        final initial =
            GameState.empty(); // empty board, status notStarted, currentPlayer X

        final result = await usecase(
          gameState: initial,
          position: Position(row: 0, column: 0),
        );

        expect(result.board.cells[0][0], Player.x);
        expect(result.currentPlayer, Player.o); // toggled
        expect(result.status, GameStatus.inProgress);
        expect(result.winner, isNull);
        // saved
        expect(repo.lastSavedGame, isNotNull);
        expect(repo.lastSavedGame!.board.cells[0][0], Player.x);
      },
    );

    test('throws for out-of-bounds move', () async {
      final repo = _FakeGameRepository();
      final usecase = MakeMove(gameRepository: repo);
      final initial = GameState.empty();

      expect(
        () =>
            usecase(gameState: initial, position: Position(row: -1, column: 0)),
        throwsA(isA<GameError>()),
      );
      expect(repo.lastSavedGame, isNull);
    });

    test('throws for move on occupied cell', () async {
      final repo = _FakeGameRepository();
      final usecase = MakeMove(gameRepository: repo);
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      final initial = GameState(
        board: board,
        status: GameStatus.inProgress,
        currentPlayer: Player.o,
      );

      expect(
        () =>
            usecase(gameState: initial, position: Position(row: 0, column: 0)),
        throwsA(isA<GameError>()),
      );
      expect(repo.lastSavedGame, isNull);
    });

    test('throws when the game is already finished', () async {
      final repo = _FakeGameRepository();
      final usecase = MakeMove(gameRepository: repo);
      final board = Board.empty();
      // Pre-make a winning line for X
      board.cells[1][0] = Player.x;
      board.cells[1][1] = Player.x;
      board.cells[1][2] = Player.x;
      final initial = GameState(
        board: board,
        status: GameStatus.finished,
        currentPlayer: Player.o,
      );

      expect(
        () =>
            usecase(gameState: initial, position: Position(row: 0, column: 0)),
        throwsA(isA<GameError>()),
      );
      expect(repo.lastSavedGame, isNull);
    });

    test('winning move sets status finished and winner', () async {
      final repo = _FakeGameRepository();
      final usecase = MakeMove(gameRepository: repo);
      final board = Board.empty();
      // X completes top row
      board.cells[0][0] = Player.x;
      board.cells[0][1] = Player.x;
      final initial = GameState(
        board: board,
        status: GameStatus.inProgress,
        currentPlayer: Player.x,
      );

      final result = await usecase(
        gameState: initial,
        position: Position(row: 0, column: 2),
      );

      expect(result.status, GameStatus.finished);
      expect(result.winner, Player.x);
      // Next player is toggled by implementation even if finished
      expect(result.currentPlayer, Player.o);
      // saved
      expect(repo.lastSavedGame, isNotNull);
      expect(repo.lastSavedGame!.status, GameStatus.finished);
      expect(repo.lastSavedGame!.winner, Player.x);
    });
  });
}
