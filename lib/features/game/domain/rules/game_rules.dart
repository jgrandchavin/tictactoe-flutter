import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

/// Core validation and win-detection rules for the Tic-Tac-Toe game.
class GameRules {
  /// Checks if the given [position] is within the valid range of the board.
  ///
  /// Returns `true` if the position is within bounds, otherwise `false`.
  static bool isMoveInBounds({required Position position}) {
    return position.row >= 0 &&
        position.row < Board.size &&
        position.column >= 0 &&
        position.column < Board.size;
  }

  /// Checks if the cell at the given [position] is empty.
  ///
  /// Returns `true` if the cell is empty, otherwise `false`.
  static bool isCellEmpty({required Board board, required Position position}) {
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

  /// Makes a move on the given [board] at the given [position].
  ///
  /// Returns the new [Board] with the move made.
  static Board makeMove({
    required Board board,
    required Position position,
    required Player player,
  }) {
    board.cells[position.row][position.column] = player;

    return board;
  }

  /// Returns the next player based on the given [player].
  ///
  /// Returns [Player.x] if the given [player] is [Player.o], otherwise returns [Player.o].
  static Player getNextPlayer({required Player player}) =>
      player == Player.x ? Player.o : Player.x;

  /// Determines the new game status based on the current game state.
  ///
  /// Returns the new [GameStatus] based on the following conditions:
  /// - If the board is empty, returns [GameStatus.notStarted].
  /// - If a player has won, returns [GameStatus.finished].
  /// - Otherwise, returns [GameStatus.inProgress].
  static GameStatus getNewGameStatus({required Board board}) {
    final isEmpty = board.cells
        .expand((row) => row)
        .every((cell) => cell == null);

    if (isEmpty) {
      return GameStatus.notStarted;
    } else if (isGameFinished(board: board)) {
      return GameStatus.finished;
    } else {
      return GameStatus.inProgress;
    }
  }

  /// Determines the new winner based on the current game state.
  ///
  /// Returns the new [Player] who has won, or `null` if there is no winner yet.
  static Player? getWinner({required Board board}) => isGameWon(board: board);
}
