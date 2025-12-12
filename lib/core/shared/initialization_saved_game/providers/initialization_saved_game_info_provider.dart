import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';

part 'initialization_saved_game_info_provider.g.dart';

@Riverpod(keepAlive: true)
class InitializationSavedGameInfoState
    extends _$InitializationSavedGameInfoState {
  @override
  InitializationSavedGameInfo? build() {
    return null;
  }

  void set(InitializationSavedGameInfo? info) {
    state = info;
  }

  void clear() {
    state = null;
  }

  InitializationSavedGameInfo? get() {
    return state;
  }
}
