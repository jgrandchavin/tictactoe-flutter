import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class Board {
  static const int size = 3;

  final List<List<Player?>> cells;

  const Board({required this.cells});

  factory Board.empty() =>
      Board(cells: List.generate(size, (_) => List.filled(size, null)));

  Board copyWith({List<List<Player?>>? cells}) {
    return Board(cells: cells ?? this.cells);
  }
}
