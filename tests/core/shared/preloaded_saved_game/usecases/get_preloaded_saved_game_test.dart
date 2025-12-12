import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/usecases/get_preloaded_saved_game.dart';

void main() {
  setUpAll(() {
    Logger.level = Level.off;
  });

  group('GetPreloadedSavedGame', () {
    test('returns null when nothing stored', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final preloaded = container.read(preloadedSavedGameStateProvider.notifier)
        ..set(null);
      final usecase = GetPreloadedSavedGame(preloadedSavedGameState: preloaded);

      final result = usecase.get();
      expect(result, isNull);
    });

    test('returns stored info', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final preloaded = container.read(preloadedSavedGameStateProvider.notifier)
        ..set(null);
      final info = PreloadedSavedGameInfo(
        board: const [
          [1, 0, 2],
          [0, 1, 0],
          [2, 0, 1],
        ],
        status: 'inProgress',
        currentPlayer: 2,
        winner: null,
      );
      preloaded.set(info);
      final usecase = GetPreloadedSavedGame(preloadedSavedGameState: preloaded);

      final result = usecase.get();
      expect(result, isNotNull);
      expect(result!.status, 'inProgress');
      expect(result.currentPlayer, 2);
      expect(result.board[0][0], 1);
    });
  });
}
