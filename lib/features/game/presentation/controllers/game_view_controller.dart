import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/mappers/preloaded_saved_game_info_mapper.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/usecases/clear_preloaded_saved_game.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/usecases/get_preloaded_saved_game.dart';
import 'package:tictactoe_flutter/core/utils/haptics_utils.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/rules/game_rules.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/make_move.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';
import 'package:tictactoe_flutter/features/game/presentation/animations/cell_anim_handle.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_state.dart';

part 'game_view_controller.g.dart';

@riverpod
class GameViewController extends _$GameViewController {
  @override
  GameViewState build() {
    final preloadedSavedGameInfo = ref
        .read(getPreloadedSavedGameProvider)
        .get();

    if (preloadedSavedGameInfo != null) {
      Future.microtask(() => ref.read(clearPreloadedSavedGameProvider).clear());
    }

    final initGameState =
        preloadedSavedGameInfo != null && preloadedSavedGameInfo.isInProgress
        ? PreloadedSavedGameInfoMapper.toDomain(preloadedSavedGameInfo)
        : GameState.empty();

    return GameViewState(gameState: initGameState);
  }

  Future<void> makeMove({required Position position}) async {
    try {
      final gameState = state.gameState;
      final newGameState = await ref
          .read(makeMoveUsecaseProvider)
          .call(gameState: gameState, position: position);

      animateTap(position);

      state = state.copyWith(gameState: newGameState);

      // NOTE If there is a winner, animate the winning line cells.
      if (newGameState.winner != null) {
        final line = GameRules.getWinningLinePositions(
          board: newGameState.board,
          winner: newGameState.winner!,
        );
        if (line != null) {
          _animateWinCells(line);
          Future<void>.delayed(
            const Duration(milliseconds: 120),
            HapticsUtils.win,
          );
        }
      } else if (newGameState.status == GameStatus.finished) {
        HapticsUtils.draw();
      }
    } catch (e) {
      animateTapError(position);
      HapticsUtils.invalidMove();
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
    ref.read(cellAnimHandleProvider(_indexOf(p))).value?.tap();

    const double d = 8.0;
    _nudgeIfInBounds(row: p.row - 1, col: p.column, delta: const Offset(0, -d));
    _nudgeIfInBounds(row: p.row + 1, col: p.column, delta: const Offset(0, d));
    _nudgeIfInBounds(row: p.row, col: p.column - 1, delta: const Offset(-d, 0));
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
}
