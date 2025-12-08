import 'package:json_annotation/json_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

part 'board_model.g.dart';

@JsonSerializable()
class BoardModel {
  @JsonKey(defaultValue: [])
  final List<List<Player?>> cells;

  const BoardModel({required this.cells});

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);

  factory BoardModel.fromDomain(Board domain) =>
      BoardModel(cells: domain.cells);

  Board toDomain() => Board(cells: cells);
}
