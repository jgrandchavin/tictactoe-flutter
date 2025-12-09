import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';

class GameViewState {
  final GameState gameState;

  const GameViewState({required this.gameState});

  GameViewState copyWith({GameState? gameState}) =>
      GameViewState(gameState: gameState ?? this.gameState);
}
