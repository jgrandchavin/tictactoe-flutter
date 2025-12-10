import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_button.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_logo.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/menu/presentation/controllers/menu_view_controller.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final GameState? savedGame = args is GameState ? args : null;
    final state = ref.watch(menuViewControllerProvider);
    ref
        .read(menuViewControllerProvider.notifier)
        .initializeWithSavedGame(savedGame);

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: AppLogo()),
          if (state.savedGame != null) ...[
            AppText.body(text: 'You have a game that is not finished'),
            const SizedBox(height: 4),
            AppButton(
              text: 'Continue Game',
              onPressed: () {
                // TODO: Navigate to game with savedGame, or restore via provider
              },
            ),
            const SizedBox(height: 16),
          ],
          AppButton(text: 'Start New Game', onPressed: () {}),
        ],
      ),
    );
  }
}
