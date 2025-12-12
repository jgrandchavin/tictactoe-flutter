class SplashViewState {
  final bool isLoading;
  final bool initializationSavedGameInfoExists;
  const SplashViewState({
    required this.isLoading,
    required this.initializationSavedGameInfoExists,
  });

  SplashViewState copyWith({
    bool? isLoading,
    bool? initializationSavedGameInfoExists,
  }) => SplashViewState(
    isLoading: isLoading ?? this.isLoading,
    initializationSavedGameInfoExists:
        initializationSavedGameInfoExists ??
        this.initializationSavedGameInfoExists,
  );
}
