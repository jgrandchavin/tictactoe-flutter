import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';

class SplashViewState {
  final bool isLoading;
  final PreloadedSavedGameInfo? preloadedSavedGameInfo;

  const SplashViewState({
    required this.isLoading,
    required this.preloadedSavedGameInfo,
  });

  SplashViewState copyWith({
    bool? isLoading,
    PreloadedSavedGameInfo? preloadedSavedGameInfo,
  }) => SplashViewState(
    isLoading: isLoading ?? this.isLoading,
    preloadedSavedGameInfo:
        preloadedSavedGameInfo ?? this.preloadedSavedGameInfo,
  );
}
