import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';

class SplashViewState {
  final bool isLoading;
  final GameState? savedGame;

  const SplashViewState({required this.isLoading, this.savedGame});

  SplashViewState copyWith({bool? isLoading, GameState? savedGame}) =>
      SplashViewState(
        isLoading: isLoading ?? this.isLoading,
        savedGame: savedGame ?? this.savedGame,
      );
}
