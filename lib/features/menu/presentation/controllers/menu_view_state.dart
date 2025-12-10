import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';

class MenuViewState {
  final GameState? savedGame;

  const MenuViewState({required this.savedGame});

  MenuViewState copyWith({GameState? savedGame}) =>
      MenuViewState(savedGame: savedGame ?? this.savedGame);
}
