import 'dart:ui' show Offset;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/make_move.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';
import 'package:tictactoe_flutter/features/game/presentation/animation/cell_anim_handle.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_state.dart';

part 'game_view_controller.g.dart';

@riverpod
class GameViewController extends _$GameViewController {
  @override
  GameViewState build(GameState? savedGame) {
    return GameViewState(gameState: savedGame ?? GameState.empty());
  }

  Future<void> makeMove({required Position position}) async {
    try {
      final gameState = state.gameState;
      final newGameState = await ref
          .read(makeMoveUsecaseProvider)
          .call(gameState: gameState, position: position);

      animateTap(position);

      state = state.copyWith(gameState: newGameState);

      // If there is a winner, animate the winning line cells.
      if (newGameState.winner != null) {
        final line = _winningLinePositions(
          newGameState.board,
          newGameState.winner!,
        );
        if (line != null) {
          _animateWinCells(line);
        }
      }
    } catch (e) {
      animateTapError(position);
    }
  }

  Future<void> startNewGame() async {
    final newGameState = await ref.read(startNewGameUsecaseProvider).call();

    state = state.copyWith(gameState: newGameState);
    _resetAllCellAnimations();
  }

  void animateTapError(Position p) {
    ref.read(cellAnimHandleProvider(_indexOf(p))).value?.tapError();
  }

  void animateTap(Position p) {
    // Self tap bounce
    ref.read(cellAnimHandleProvider(_indexOf(p))).value?.tap();

    // Neighbor nudges
    const double d = 8.0;
    // up
    _nudgeIfInBounds(row: p.row - 1, col: p.column, delta: const Offset(0, -d));
    // down
    _nudgeIfInBounds(row: p.row + 1, col: p.column, delta: const Offset(0, d));
    // left
    _nudgeIfInBounds(row: p.row, col: p.column - 1, delta: const Offset(-d, 0));
    // right
    _nudgeIfInBounds(row: p.row, col: p.column + 1, delta: const Offset(d, 0));
  }

  int _indexOf(Position p) => (p.row * Board.size + p.column).toInt();

  void _nudgeIfInBounds({
    required int row,
    required int col,
    required Offset delta,
  }) {
    if (row < 0 || row >= Board.size || col < 0 || col >= Board.size) return;
    final idx = (row * Board.size + col);
    ref.read(cellAnimHandleProvider(idx)).value?.nudge(delta);
  }

  void _animateWinCells(List<Position> cells) {
    for (final p in cells) {
      ref.read(cellAnimHandleProvider(_indexOf(p))).value?.win(repeat: true);
    }
  }

  void _resetAllCellAnimations() {
    for (int i = 0; i < Board.size * Board.size; i++) {
      final handle = ref.read(cellAnimHandleProvider(i)).value;
      handle?.stopWin();
      handle?.appear();
    }
  }

  List<Position>? _winningLinePositions(Board board, dynamic winner) {
    // Rows
    for (int r = 0; r < Board.size; r++) {
      final row = board.cells[r];
      if (row.every((cell) => cell == winner)) {
        return List.generate(Board.size, (c) => Position(row: r, column: c));
      }
    }
    // Columns
    for (int c = 0; c < Board.size; c++) {
      final column = List.generate(Board.size, (r) => board.cells[r][c]);
      if (column.every((cell) => cell == winner)) {
        return List.generate(Board.size, (r) => Position(row: r, column: c));
      }
    }
    // Main diagonal
    final mainDiag = List.generate(Board.size, (i) => board.cells[i][i]);
    if (mainDiag.every((cell) => cell == winner)) {
      return List.generate(Board.size, (i) => Position(row: i, column: i));
    }
    // Anti-diagonal
    final antiDiag = List.generate(
      Board.size,
      (i) => board.cells[i][Board.size - 1 - i],
    );
    if (antiDiag.every((cell) => cell == winner)) {
      return List.generate(
        Board.size,
        (i) => Position(row: i, column: Board.size - 1 - i),
      );
    }
    return null;
  }
}
