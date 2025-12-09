import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_state_model.dart';

abstract class GameLocalDataSource {
  Future<GameStateModel?> getSavedGame();
  Future<void> saveGame({required GameStateModel gameState});
  Future<void> clearGame();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final SharedPreferences prefs;

  GameLocalDataSourceImpl({required this.prefs});

  @override
  Future<GameStateModel?> getSavedGame() async {
    final gameState = prefs.getString('game_state');
    return gameState != null
        ? GameStateModel.fromJson(json.decode(gameState))
        : null;
  }

  @override
  Future<void> saveGame({required GameStateModel gameState}) async {
    await prefs.setString('game_state', json.encode(gameState.toJson()));
  }

  @override
  Future<void> clearGame() async {
    await prefs.remove('game_state');
  }
}
