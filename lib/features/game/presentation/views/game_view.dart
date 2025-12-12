import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/board_widget.dart';
import 'package:tictactoe_flutter/features/game/presentation/widgets/game_bottom_buttons.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            BoardWidget(),
            const Spacer(),
            const SizedBox(height: 32),
            GameBottomButtons(),
          ],
        ),
      ),
    );
  }
}
