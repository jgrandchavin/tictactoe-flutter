import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/core/utils/logger.dart';

part 'get_preloaded_saved_game.g.dart';

class GetPreloadedSavedGame {
  final PreloadedSavedGameState preloadedSavedGameState;

  GetPreloadedSavedGame({required this.preloadedSavedGameState});

  PreloadedSavedGameInfo? get() {
    final preloadedSavedGameInfo = preloadedSavedGameState.get();
    log.d('[PRELOADED_SAVED_GAME] Getting preloaded saved game info');
    return preloadedSavedGameInfo;
  }
}

@Riverpod(keepAlive: true)
GetPreloadedSavedGame getPreloadedSavedGame(Ref ref) {
  final preloadedSavedGameState = ref.watch(
    preloadedSavedGameStateProvider.notifier,
  );

  return GetPreloadedSavedGame(
    preloadedSavedGameState: preloadedSavedGameState,
  );
}
