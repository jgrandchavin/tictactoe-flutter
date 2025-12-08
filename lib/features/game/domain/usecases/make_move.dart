import 'package:tictactoe_flutter/core/errors/game_error.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe_flutter/features/game/domain/rules/game_rules.dart';

class MakeMove {
  final GameRepository gameRepository;

  MakeMove({required this.gameRepository});

  Future<void> call({
    required GameState gameState,
    required Position position,
    required Player player,
  }) async {
    final isMoveValid = GameRules.isMoveValid(
      board: gameState.board,
      position: position,
    );

    if (!isMoveValid) {
      throw GameError.invalidMove();
    }

    final newBoard = gameState.board.copyWith(
      cells: gameState.board.cells
          .map((row) => row.map((cell) => cell).toList())
          .toList(),
    );

    final newGameStatus = GameRules.getGameStatus(board: newBoard);

    final newGameState = gameState.copyWith(
      board: newBoard,
      status: newGameStatus,
    );

    return gameRepository.saveGame(gameState: newGameState);
  }
}
