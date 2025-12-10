import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/menu/presentation/controllers/menu_view_state.dart';

part 'menu_view_controller.g.dart';

@riverpod
class MenuViewController extends _$MenuViewController {
  @override
  MenuViewState build() {
    return MenuViewState(savedGame: null);
  }
}
