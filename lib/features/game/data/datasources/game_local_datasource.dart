import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_state_model.dart';

abstract class GameLocalDataSource {
  Future<GameStateModel> getSavedGame();
  Future<void> saveGame({required GameStateModel gameState});
  Future<void> clearGame();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  @override
  Future<GameStateModel> getSavedGame() async {
    final prefs = await SharedPreferences.getInstance();
    final gameState = prefs.getString('game_state');
    return GameStateModel.fromJson(json.decode(gameState ?? '{}'));
  }

  @override
  Future<void> saveGame({required GameStateModel gameState}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('game_state', json.encode(gameState.toJson()));
  }

  @override
  Future<void> clearGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('game_state');
  }
}
