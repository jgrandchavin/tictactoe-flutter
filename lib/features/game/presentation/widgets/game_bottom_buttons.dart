import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe_flutter/core/router/routes.dart';
import 'package:tictactoe_flutter/core/ui/animations/appear_animation.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_button.dart';
import 'package:tictactoe_flutter/features/game/domain/enums/game_status.dart';
import 'package:tictactoe_flutter/features/game/presentation/controllers/game_view_controller.dart';

class GameBottomButtons extends ConsumerWidget {
  const GameBottomButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameViewControllerProvider);
    final controller = ref.read(gameViewControllerProvider.notifier);

    return Column(
      children: [
        Visibility(
          visible: state.gameState.status == GameStatus.finished,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: AppearAnimation(
            key: Key(
              'play_again_button ${state.gameState.status.name}',
            ), // NOTE: Needed to ensure the animation is triggered when the visibility changes.
            child: AppButton(
              onPressed: () {
                controller.startNewGame();
              },
              text: 'Play Again',
            ),
          ),
        ),
        SizedBox(height: 8),
        AppButton(
          onPressed: () {
            controller.startNewGame();
            if (context.mounted) {
              context.pushReplacementNamed(Routes.menu);
            }
          },
          text: 'Exit Game',
        ),
      ],
    );
  }
}
