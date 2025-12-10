import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_flutter/core/providers/shared_preferences_provider.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_state_model.dart';

part 'game_local_datasource.g.dart';

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

@Riverpod(keepAlive: true)
GameLocalDataSource gameLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GameLocalDataSourceImpl(prefs: prefs);
}
