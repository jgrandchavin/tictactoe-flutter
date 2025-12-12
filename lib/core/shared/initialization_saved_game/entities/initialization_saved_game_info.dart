class InitializationSavedGameInfo {
  final List<List<int>> board;
  final String status;
  final int currentPlayer;
  final int? winner;

  const InitializationSavedGameInfo({
    required this.board,
    required this.status,
    required this.currentPlayer,
    required this.winner,
  });

  bool get isInProgress => status == 'inProgress';
}
