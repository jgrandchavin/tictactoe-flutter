import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/board.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/position.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/player.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final Function(Position position) onCellTap;

  const BoardWidget({super.key, required this.board, required this.onCellTap});

  @override
  Widget build(BuildContext context) {
    final cells = board.cells;

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Board.size,
        ),
        itemCount: Board.size * Board.size,
        itemBuilder: (context, index) {
          final row = index ~/ Board.size;
          final col = index % Board.size;
          final player = cells[row][col];

          return GestureDetector(
            onTap: () => onCellTap(Position(row: row, column: col)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: row == 0 ? Colors.transparent : Colors.black26,
                  ),
                  left: BorderSide(
                    color: col == 0 ? Colors.transparent : Colors.black26,
                  ),
                  right: const BorderSide(color: Colors.black26),
                  bottom: const BorderSide(color: Colors.black26),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _playerToSymbol(player),
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  String _playerToSymbol(Player? player) {
    switch (player) {
      case Player.x:
        return 'X';
      case Player.o:
        return 'O';
      case null:
        return '';
    }
  }
}
