import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/core/utils/logger.dart';

part 'clear_preloaded_saved_game.g.dart';

class ClearPreloadedSavedGame {
  final PreloadedSavedGameState preloadedSavedGameState;

  ClearPreloadedSavedGame({required this.preloadedSavedGameState});

  void clear() {
    preloadedSavedGameState.clear();
    log.d('[PRELOADED_SAVED_GAME] Cleared preloaded saved game info');
  }
}

@Riverpod(keepAlive: true)
ClearPreloadedSavedGame clearPreloadedSavedGame(Ref ref) {
  final preloadedSavedGameState = ref.watch(
    preloadedSavedGameStateProvider.notifier,
  );

  return ClearPreloadedSavedGame(
    preloadedSavedGameState: preloadedSavedGameState,
  );
}
