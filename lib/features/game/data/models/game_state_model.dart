import 'package:json_annotation/json_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/converters/game_status_converter.dart';
import 'package:tictactoe_flutter/features/game/data/converters/player_converter.dart';
import 'package:tictactoe_flutter/features/game/data/models/board_model.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

part 'game_state_model.g.dart';

@JsonSerializable()
class GameStateModel {
  final BoardModel board;

  @GameStatusConverter()
  final GameStatus status;

  @PlayerConverter()
  final Player currentPlayer;

  @PlayerConverter()
  final Player? winner;

  const GameStateModel({
    required this.board,
    required this.status,
    required this.currentPlayer,
    required this.winner,
  });

  factory GameStateModel.fromJson(Map<String, dynamic> json) =>
      _$GameStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateModelToJson(this);

  factory GameStateModel.fromDomain(GameState domain) => GameStateModel(
    board: BoardModel.fromDomain(domain.board),
    status: domain.status,
    currentPlayer: domain.currentPlayer,
    winner: domain.winner,
  );

  GameState toDomain() => GameState(
    board: board.toDomain(),
    status: status,
    currentPlayer: currentPlayer,
    winner: winner,
  );
}
