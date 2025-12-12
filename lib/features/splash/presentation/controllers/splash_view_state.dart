import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';

class SplashViewState {
  final bool isLoading;
  final InitializationSavedGameInfo? initializationSavedGameInfo;

  const SplashViewState({
    required this.isLoading,
    required this.initializationSavedGameInfo,
  });

  SplashViewState copyWith({
    bool? isLoading,
    InitializationSavedGameInfo? initializationSavedGameInfo,
  }) => SplashViewState(
    isLoading: isLoading ?? this.isLoading,
    initializationSavedGameInfo:
        initializationSavedGameInfo ?? this.initializationSavedGameInfo,
  );
}
