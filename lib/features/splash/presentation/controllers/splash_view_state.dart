class SplashViewState {
  final bool isLoading;
  final bool savedGameExists;

  const SplashViewState({
    required this.isLoading,
    this.savedGameExists = false,
  });

  SplashViewState copyWith({bool? isLoading, bool? savedGameExists}) =>
      SplashViewState(
        isLoading: isLoading ?? this.isLoading,
        savedGameExists: savedGameExists ?? this.savedGameExists,
      );
}
