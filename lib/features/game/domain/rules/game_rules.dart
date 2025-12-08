import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

/// Core validation and win-detection rules for the Tic-Tac-Toe game.
class GameRules {
  /// Checks whether a move is allowed at [position] on the given [board].
  ///
  /// Returns `true` if the target cell is empty, otherwise `false`.
  static bool isMoveValid({required Board board, required Position position}) {
    if (!GameRules.isInBounds(position: position)) return false;
    if (GameRules.isGameFinished(board: board)) return false;

    return board.cells[position.row][position.column] == null;
  }

  /// Determines if the game is finished.
  ///
  /// Returns `true` when either:
  /// - a player has already won, or
  /// - there are no empty cells left on the board.
  static bool isGameFinished({required Board board}) {
    return board.cells.every((row) => row.every((cell) => cell != null)) ||
        isGameWon(board: board) != null;
  }

  /// Returns the [Player] who has won, or `null` if there is no winner yet.
  ///
  /// Checks all rows, columns, and both diagonals for a full line of the same
  /// player. Uses the square board size defined by `Board.size`.
  static Player? isGameWon({required Board board}) {
    for (var player in Player.values) {
      // Check rows
      for (var row in board.cells) {
        if (row.every((cell) => cell == player)) {
          return player;
        }
      }

      // Check columns
      for (int col = 0; col < Board.size; col++) {
        if (List.generate(
          Board.size,
          (row) => board.cells[row][col],
        ).every((cell) => cell == player)) {
          return player;
        }
      }

      // Check main diagonal
      if (List.generate(
        Board.size,
        (i) => board.cells[i][i],
      ).every((cell) => cell == player)) {
        return player;
      }
      // Check anti-diagonal
      if (List.generate(
        Board.size,
        (i) => board.cells[i][Board.size - 1 - i],
      ).every((cell) => cell == player)) {
        return player;
      }
    }
    return null;
  }

  /// Checks if the given [position] is within the valid range of the board.
  ///
  /// Returns `true` if the position is within bounds, otherwise `false`.
  static bool isInBounds({required Position position}) {
    return position.row >= 0 &&
        position.row < Board.size &&
        position.column >= 0 &&
        position.column < Board.size;
  }

  /// Returns the [GameStatus] of the game.
  static GameStatus getGameStatus({required Board board}) {
    if (isGameWon(board: board) != null) {
      return GameStatus.finished;
    }
    if (isGameFinished(board: board)) {
      return GameStatus.finished;
    }
    return GameStatus.inProgress;
  }
}
