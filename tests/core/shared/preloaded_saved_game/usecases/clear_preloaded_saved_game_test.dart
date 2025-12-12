import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/usecases/clear_preloaded_saved_game.dart';

void main() {
  setUpAll(() {
    Logger.level = Level.off;
  });

  group('ClearPreloadedSavedGame', () {
    test('clears stored info (sets state to null)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final preloaded = container.read(preloadedSavedGameStateProvider.notifier)
        ..set(null);
      preloaded.set(
        const PreloadedSavedGameInfo(
          board: [
            [1, 1, 1],
            [0, 0, 0],
            [0, 0, 0],
          ],
          status: 'finished',
          currentPlayer: 2,
          winner: 1,
        ),
      );
      expect(preloaded.get(), isNotNull);

      final usecase = ClearPreloadedSavedGame(
        preloadedSavedGameState: preloaded,
      );
      usecase.clear();

      expect(preloaded.get(), isNull);
    });
  });
}
