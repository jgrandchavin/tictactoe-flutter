import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';
import 'package:tictactoe_flutter/features/menu/presentation/controllers/menu_view_state.dart';

part 'menu_view_controller.g.dart';

@riverpod
class MenuViewController extends _$MenuViewController {
  @override
  MenuViewState build(GameState? savedGame) {
    return MenuViewState(savedGame: savedGame);
  }

  Future<void> startNewGame() async {
    final newGameState = await ref.read(startNewGameUsecaseProvider).call();

    state = state.copyWith(savedGame: newGameState);
  }
}
