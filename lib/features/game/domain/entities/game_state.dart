import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';

class GameState {
  final Board board;

  final GameStatus status;

  const GameState({required this.board, required this.status});
  factory GameState.empty() =>
      GameState(board: Board.empty(), status: GameStatus.notStarted);

  GameState copyWith({Board? board, GameStatus? status}) =>
      GameState(board: board ?? this.board, status: status ?? this.status);
}
