import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class InitializationSavedGameInfoMapper {
  static InitializationSavedGameInfo fromDomain(GameState domain) {
    return InitializationSavedGameInfo(
      board: domain.board.cells
          .map(
            (row) => row
                .map((cell) => cell == null ? 0 : (cell == Player.x ? 1 : 2))
                .toList(),
          )
          .toList(),
      status: _statusToString(domain.status),
      currentPlayer: domain.currentPlayer == Player.x ? 1 : 2,
      winner: domain.winner == null
          ? null
          : (domain.winner == Player.x ? 1 : 2),
    );
  }

  static String _statusToString(GameStatus status) {
    switch (status) {
      case GameStatus.notStarted:
        return 'notStarted';
      case GameStatus.inProgress:
        return 'inProgress';
      case GameStatus.finished:
        return 'finished';
    }
  }

  static GameState toDomain(InitializationSavedGameInfo info) {
    final cells = info.board
        .map(
          (row) => row
              .map<Player?>(
                (v) => v == 0 ? null : (v == 1 ? Player.x : Player.o),
              )
              .toList(),
        )
        .toList();
    final status = _statusFromString(info.status);
    final current = info.currentPlayer == 1 ? Player.x : Player.o;
    final win = info.winner == null
        ? null
        : (info.winner == 1 ? Player.x : Player.o);
    return GameState(
      board: Board(cells: cells),
      status: status,
      currentPlayer: current,
      winner: win,
    );
  }

  static GameStatus _statusFromString(String s) {
    switch (s) {
      case 'inProgress':
        return GameStatus.inProgress;
      case 'finished':
        return GameStatus.finished;
      case 'notStarted':
      default:
        return GameStatus.notStarted;
    }
  }
}
