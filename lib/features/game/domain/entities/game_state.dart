import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class GameState {
  final Board board;

  final Player currentPlayer;

  final GameStatus status;

  final Player? winner;

  const GameState({
    required this.board,
    required this.status,
    required this.currentPlayer,
    required this.winner,
  });
  factory GameState.empty() => GameState(
    board: Board.empty(),
    status: GameStatus.notStarted,
    currentPlayer: Player.x,
    winner: null,
  );

  GameState copyWith({
    Board? board,
    GameStatus? status,
    Player? nextPlayer,
    Player? winner,
  }) => GameState(
    board: board ?? this.board,
    status: status ?? this.status,
    currentPlayer: nextPlayer ?? this.currentPlayer,
    winner: winner ?? this.winner,
  );
}
