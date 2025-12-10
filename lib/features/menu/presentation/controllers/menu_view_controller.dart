import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/menu/presentation/controllers/menu_view_state.dart';

part 'menu_view_controller.g.dart';

@riverpod
class MenuViewController extends _$MenuViewController {
  bool _argsInitialized = false;

  @override
  MenuViewState build() {
    return const MenuViewState(savedGame: null);
  }

  void initializeWithSavedGame(GameState? savedGame) {
    if (_argsInitialized) return;
    _argsInitialized = true;
    state = state.copyWith(savedGame: savedGame);
  }
}
