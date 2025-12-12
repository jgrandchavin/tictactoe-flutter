import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/rules/game_rules.dart';

void main() {
  group('GameRules.isMoveInBounds', () {
    test('returns true for positions inside the 3x3 board', () {
      expect(
        GameRules.isMoveInBounds(position: Position(row: 0, column: 0)),
        isTrue,
      );
      expect(
        GameRules.isMoveInBounds(position: Position(row: 2, column: 2)),
        isTrue,
      );
      expect(
        GameRules.isMoveInBounds(position: Position(row: 1, column: 2)),
        isTrue,
      );
    });

    test('returns false for positions outside the board', () {
      expect(
        GameRules.isMoveInBounds(position: Position(row: -1, column: 0)),
        isFalse,
      );
      expect(
        GameRules.isMoveInBounds(position: Position(row: 0, column: -1)),
        isFalse,
      );
      expect(
        GameRules.isMoveInBounds(position: Position(row: 3, column: 0)),
        isFalse,
      );
      expect(
        GameRules.isMoveInBounds(position: Position(row: 0, column: 3)),
        isFalse,
      );
    });
  });

  group('GameRules.isCellEmpty', () {
    test('returns true for empty cell and false after filled', () {
      final board = Board.empty();
      final pos = Position(row: 1, column: 1);
      expect(GameRules.isCellEmpty(board: board, position: pos), isTrue);

      board.cells[pos.row][pos.column] = Player.x;
      expect(GameRules.isCellEmpty(board: board, position: pos), isFalse);
    });
  });

  group('GameRules.makeMove', () {
    test('places the player at the given position', () {
      final board = Board.empty();
      final pos = Position(row: 2, column: 0);
      final updated = GameRules.makeMove(
        board: board,
        position: pos,
        player: Player.o,
      );
      expect(updated.cells[pos.row][pos.column], equals(Player.o));
    });
  });

  group('GameRules.isGameWon', () {
    test('detects row win', () {
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      board.cells[0][1] = Player.x;
      board.cells[0][2] = Player.x;
      expect(GameRules.isGameWon(board: board), equals(Player.x));
    });

    test('detects column win', () {
      final board = Board.empty();
      board.cells[0][1] = Player.o;
      board.cells[1][1] = Player.o;
      board.cells[2][1] = Player.o;
      expect(GameRules.isGameWon(board: board), equals(Player.o));
    });

    test('detects main diagonal win', () {
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      board.cells[1][1] = Player.x;
      board.cells[2][2] = Player.x;
      expect(GameRules.isGameWon(board: board), equals(Player.x));
    });

    test('detects anti-diagonal win', () {
      final board = Board.empty();
      board.cells[0][2] = Player.o;
      board.cells[1][1] = Player.o;
      board.cells[2][0] = Player.o;
      expect(GameRules.isGameWon(board: board), equals(Player.o));
    });

    test('returns null when there is no winner', () {
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      board.cells[0][1] = Player.o;
      expect(GameRules.isGameWon(board: board), isNull);
    });
  });

  group('GameRules.isGameFinished', () {
    test('returns false for empty board', () {
      final board = Board.empty();
      expect(GameRules.isGameFinished(board: board), isFalse);
    });

    test('returns true when a player has won', () {
      final board = Board.empty();
      board.cells[2][0] = Player.x;
      board.cells[2][1] = Player.x;
      board.cells[2][2] = Player.x;
      expect(GameRules.isGameFinished(board: board), isTrue);
    });

    test('returns true when the board is full (draw)', () {
      final board = Board.empty();
      // Draw pattern (no 3-in-a-row):
      // X O X
      // X O O
      // O X X
      board.cells[0][0] = Player.x;
      board.cells[0][1] = Player.o;
      board.cells[0][2] = Player.x;
      board.cells[1][0] = Player.x;
      board.cells[1][1] = Player.o;
      board.cells[1][2] = Player.o;
      board.cells[2][0] = Player.o;
      board.cells[2][1] = Player.x;
      board.cells[2][2] = Player.x;

      expect(GameRules.isGameWon(board: board), isNull);
      expect(GameRules.isGameFinished(board: board), isTrue);
    });
  });

  group('GameRules.getNextPlayer', () {
    test('toggles between players', () {
      expect(GameRules.getNextPlayer(player: Player.x), equals(Player.o));
      expect(GameRules.getNextPlayer(player: Player.o), equals(Player.x));
    });
  });

  group('GameRules.getNewGameStatus', () {
    test('returns notStarted for empty board', () {
      final board = Board.empty();
      expect(GameRules.getNewGameStatus(board: board), GameStatus.notStarted);
    });

    test('returns inProgress when there are some moves but no winner', () {
      final board = Board.empty();
      board.cells[1][1] = Player.x;
      expect(GameRules.getNewGameStatus(board: board), GameStatus.inProgress);
    });

    test('returns finished when there is a winner', () {
      final board = Board.empty();
      board.cells[0][0] = Player.o;
      board.cells[0][1] = Player.o;
      board.cells[0][2] = Player.o;
      expect(GameRules.getNewGameStatus(board: board), GameStatus.finished);
    });
  });

  group('GameRules.getWinner', () {
    test('returns the winner when present', () {
      final board = Board.empty();
      board.cells[2][0] = Player.x;
      board.cells[2][1] = Player.x;
      board.cells[2][2] = Player.x;
      expect(GameRules.getWinner(board: board), equals(Player.x));
    });

    test('returns null when there is no winner', () {
      final board = Board.empty();
      expect(GameRules.getWinner(board: board), isNull);
    });
  });

  group('GameRules.getWinningLinePositions', () {
    test('returns positions for winning row', () {
      final board = Board.empty();
      board.cells[1][0] = Player.x;
      board.cells[1][1] = Player.x;
      board.cells[1][2] = Player.x;
      final positions = GameRules.getWinningLinePositions(
        board: board,
        winner: Player.x,
      )!;
      expect(positions.length, 3);
      expect(positions[0], Position(row: 1, column: 0));
      expect(positions[1], Position(row: 1, column: 1));
      expect(positions[2], Position(row: 1, column: 2));
    });

    test('returns positions for winning column', () {
      final board = Board.empty();
      board.cells[0][2] = Player.o;
      board.cells[1][2] = Player.o;
      board.cells[2][2] = Player.o;
      final positions = GameRules.getWinningLinePositions(
        board: board,
        winner: Player.o,
      )!;
      expect(positions.length, 3);
      expect(positions[0], Position(row: 0, column: 2));
      expect(positions[1], Position(row: 1, column: 2));
      expect(positions[2], Position(row: 2, column: 2));
    });

    test('returns positions for winning main diagonal', () {
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      board.cells[1][1] = Player.x;
      board.cells[2][2] = Player.x;
      final positions = GameRules.getWinningLinePositions(
        board: board,
        winner: Player.x,
      )!;
      expect(positions.length, 3);
      expect(positions[0], Position(row: 0, column: 0));
      expect(positions[1], Position(row: 1, column: 1));
      expect(positions[2], Position(row: 2, column: 2));
    });

    test('returns positions for winning anti-diagonal', () {
      final board = Board.empty();
      board.cells[0][2] = Player.o;
      board.cells[1][1] = Player.o;
      board.cells[2][0] = Player.o;
      final positions = GameRules.getWinningLinePositions(
        board: board,
        winner: Player.o,
      )!;
      expect(positions.length, 3);
      expect(positions[0], Position(row: 0, column: 2));
      expect(positions[1], Position(row: 1, column: 1));
      expect(positions[2], Position(row: 2, column: 0));
    });

    test('returns null when there is no winning line for given winner', () {
      final board = Board.empty();
      board.cells[0][0] = Player.x;
      final positions = GameRules.getWinningLinePositions(
        board: board,
        winner: Player.x,
      );
      expect(positions, isNull);
    });
  });
}
