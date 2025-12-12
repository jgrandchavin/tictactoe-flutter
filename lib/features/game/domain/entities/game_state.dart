import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  factory GameState({
    @Default(Board()) Board board,
    @Default(GameStatus.notStarted) GameStatus status,
    @Default(Player.x) Player currentPlayer,
    @Default(null) Player? winner,
  }) = _GameState;

  factory GameState.empty() => GameState(board: Board.empty());
}
