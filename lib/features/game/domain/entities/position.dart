class Position {
  final int row;
  final int column;

  const Position({required this.row, required this.column});

  factory Position.empty() => Position(row: 0, column: 0);
}
