// import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';

part 'preloaded_saved_game_state.g.dart';

@Riverpod(keepAlive: true)
class PreloadedSavedGameState extends _$PreloadedSavedGameState {
  @override
  PreloadedSavedGameInfo? build() {
    return null;
  }

  void set(PreloadedSavedGameInfo? info) {
    state = info;
  }

  void clear() {
    state = null;
  }

  PreloadedSavedGameInfo? get() => state;
}
