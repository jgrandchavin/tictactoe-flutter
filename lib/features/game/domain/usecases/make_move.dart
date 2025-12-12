import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/errors/game_error.dart';
import 'package:tictactoe_flutter/core/utils/logger.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe_flutter/features/game/domain/rules/game_rules.dart';

part 'make_move.g.dart';

class MakeMove {
  final GameRepository gameRepository;

  MakeMove({required this.gameRepository});

  Future<GameState> call({
    required GameState gameState,
    required Position position,
  }) async {
    final isMoveInBounds = GameRules.isMoveInBounds(position: position);
    if (!isMoveInBounds) {
      throw GameError.invalidMove();
    }

    final isCellEmpty = GameRules.isCellEmpty(
      board: gameState.board,
      position: position,
    );

    final isGameFinished = GameRules.isGameFinished(board: gameState.board);

    if (!isCellEmpty || isGameFinished) {
      throw GameError.invalidMove();
    }

    final newBoard = GameRules.makeMove(
      board: gameState.board,
      player: gameState.currentPlayer,
      position: position,
    );

    final nextPlayer = GameRules.getNextPlayer(player: gameState.currentPlayer);

    final newGameStatus = GameRules.getNewGameStatus(board: newBoard);

    Player? winner;

    if (newGameStatus == GameStatus.finished) {
      winner = GameRules.getWinner(board: newBoard);
    }

    final newGameState = gameState.copyWith(
      board: newBoard,
      currentPlayer: nextPlayer,
      status: newGameStatus,
      winner: winner,
    );

    unawaited(gameRepository.saveGame(gameState: newGameState));

    log.d('[MAKE_MOVE] Position: $position');

    return newGameState;
  }
}

@Riverpod(keepAlive: true)
MakeMove makeMoveUsecase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return MakeMove(gameRepository: gameRepository);
}
