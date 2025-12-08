import 'package:json_annotation/json_annotation.dart';
import 'package:tictactoe_flutter/features/game/data/models/board_model.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_status_model.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';

part 'game_state_model.g.dart';

@JsonSerializable()
class GameStateModel {
  final BoardModel board;

  final GameStatusModel status;

  const GameStateModel({required this.board, required this.status});

  factory GameStateModel.fromJson(Map<String, dynamic> json) =>
      _$GameStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateModelToJson(this);

  factory GameStateModel.empty() => GameStateModel(
    board: BoardModel(cells: []),
    status: GameStatusModel(value: GameStatus.notStarted),
  );

  factory GameStateModel.fromDomain(GameState domain) => GameStateModel(
    board: BoardModel.fromDomain(domain.board),
    status: GameStatusModel.fromDomain(domain.status),
  );

  GameState toDomain() =>
      GameState(board: board.toDomain(), status: status.toDomain());
}
