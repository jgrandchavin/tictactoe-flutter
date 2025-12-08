import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/rules/game_rules.dart';

void main() {
  Board emptyBoard() {
    final size = Board.size;
    return Board(
      cells: List.generate(
        size,
        (_) => List<Player?>.filled(size, null, growable: false),
        growable: false,
      ),
    );
  }

  test('isMoveValid returns true for empty in-bounds cell', () {
    final board = emptyBoard();
    final pos = const Position(row: 1, column: 1);
    expect(GameRules.isMoveValid(board: board, position: pos), isTrue);
  });

  test('isMoveValid returns false for occupied cell', () {
    final board = emptyBoard();
    board.cells[0][0] = Player.x;
    expect(
      GameRules.isMoveValid(
        board: board,
        position: const Position(row: 0, column: 0),
      ),
      isFalse,
    );
  });

  test('isMoveValid returns false when out of bounds', () {
    final board = emptyBoard();
    expect(
      GameRules.isMoveValid(
        board: board,
        position: const Position(row: -1, column: 0),
      ),
      isFalse,
    );
    expect(
      GameRules.isMoveValid(
        board: board,
        position: const Position(row: 0, column: -1),
      ),
      isFalse,
    );
    expect(
      GameRules.isMoveValid(
        board: board,
        position: Position(row: Board.size, column: 0),
      ),
      isFalse,
    );
    expect(
      GameRules.isMoveValid(
        board: board,
        position: Position(row: 0, column: Board.size),
      ),
      isFalse,
    );
  });

  test('isMoveValid returns false when game is already finished (win)', () {
    final board = emptyBoard();
    // Row win for X
    for (var c = 0; c < Board.size; c++) {
      board.cells[0][c] = Player.x;
    }
    expect(GameRules.isGameWon(board: board), equals(Player.x));
    // Any further move should be invalid
    expect(
      GameRules.isMoveValid(
        board: board,
        position: const Position(row: 2, column: 2),
      ),
      isFalse,
    );
  });

  group('isGameFinished', () {
    test('returns false for an empty board', () {
      final board = emptyBoard();
      expect(GameRules.isGameFinished(board: board), isFalse);
    });

    test('returns true for a full board with no winner (draw)', () {
      final board = Board(
        cells: <List<Player?>>[
          <Player?>[Player.x, Player.o, Player.x],
          <Player?>[Player.x, Player.o, Player.o],
          <Player?>[Player.o, Player.x, Player.x],
        ],
      );
      expect(GameRules.isGameWon(board: board), isNull);
      expect(GameRules.isGameFinished(board: board), isTrue);
    });

    test('returns true when there is a winner', () {
      final board = emptyBoard();
      for (var c = 0; c < Board.size; c++) {
        board.cells[1][c] = Player.o;
      }
      expect(GameRules.isGameFinished(board: board), isTrue);
    });
  });

  group('isGameWon', () {
    test('detects row win', () {
      final board = emptyBoard();
      for (var c = 0; c < Board.size; c++) {
        board.cells[2][c] = Player.x;
      }
      expect(GameRules.isGameWon(board: board), equals(Player.x));
    });

    test('detects column win', () {
      final board = emptyBoard();
      for (var r = 0; r < Board.size; r++) {
        board.cells[r][1] = Player.o;
      }
      expect(GameRules.isGameWon(board: board), equals(Player.o));
    });

    test('detects main diagonal win', () {
      final board = emptyBoard();
      for (var i = 0; i < Board.size; i++) {
        board.cells[i][i] = Player.x;
      }
      expect(GameRules.isGameWon(board: board), equals(Player.x));
    });

    test('detects anti-diagonal win', () {
      final board = emptyBoard();
      for (var i = 0; i < Board.size; i++) {
        board.cells[i][Board.size - 1 - i] = Player.o;
      }
      expect(GameRules.isGameWon(board: board), equals(Player.o));
    });

    test('returns null when there is no winner', () {
      final board = emptyBoard();
      board.cells[0][0] = Player.x;
      board.cells[0][1] = Player.o;
      board.cells[1][1] = Player.x;
      expect(GameRules.isGameWon(board: board), isNull);
    });
  });
}
