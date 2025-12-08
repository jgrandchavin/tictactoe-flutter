class GameError implements Exception {
  final GameErrorType type;
  final String message;

  const GameError(this.type, this.message);

  const GameError.invalidMove()
    : type = GameErrorType.invalidMove,
      message = 'Invalid move';
}

enum GameErrorType { invalidMove }
