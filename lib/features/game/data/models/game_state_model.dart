import 'package:json_annotation/json_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/models/board_model.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_status_model.dart';
import 'package:tictactoe_flutter/features/game/data/models/player_model.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

part 'game_state_model.g.dart';

@JsonSerializable()
class GameStateModel {
  final BoardModel board;

  final GameStatusModel status;

  final PlayerModel currentPlayer;

  final PlayerModel? winner;

  const GameStateModel({
    required this.board,
    required this.status,
    required this.currentPlayer,
    required this.winner,
  });

  factory GameStateModel.fromJson(Map<String, dynamic> json) =>
      _$GameStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateModelToJson(this);

  factory GameStateModel.empty() => GameStateModel(
    board: BoardModel(cells: []),
    status: GameStatusModel(value: GameStatus.notStarted),
    currentPlayer: PlayerModel(value: Player.x),
    winner: null,
  );

  factory GameStateModel.fromDomain(GameState domain) => GameStateModel(
    board: BoardModel.fromDomain(domain.board),
    status: GameStatusModel.fromDomain(domain.status),
    currentPlayer: PlayerModel.fromDomain(domain.currentPlayer),
    winner: domain.winner != null
        ? PlayerModel.fromDomain(domain.winner!)
        : null,
  );

  GameState toDomain() => GameState(
    board: board.toDomain(),
    status: status.toDomain(),
    currentPlayer: currentPlayer.toDomain(),
    winner: winner?.toDomain(),
  );
}
