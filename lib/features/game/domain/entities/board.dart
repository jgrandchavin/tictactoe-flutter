import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

part 'board.freezed.dart';

@freezed
abstract class Board with _$Board {
  static const int size = 3;

  const factory Board({@Default([]) List<List<Player?>> cells}) = _Board;

  factory Board.empty() => Board(
    cells: List.generate(size, (_) => List<Player?>.filled(size, null)),
  );
}
