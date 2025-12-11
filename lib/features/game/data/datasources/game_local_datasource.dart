import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/services/local_storage/local_storage_service.dart';
import 'package:tictactoe_flutter/features/game/data/models/game_state_model.dart';

part 'game_local_datasource.g.dart';

abstract class GameLocalDataSource {
  Future<GameStateModel?> getSavedGame();
  Future<void> saveGame({required GameStateModel gameState});
  Future<void> clearGame();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final LocalStorageService localStorageService;

  GameLocalDataSourceImpl({required this.localStorageService});

  @override
  Future<GameStateModel?> getSavedGame() async {
    final gameState = await localStorageService.get('game_state');
    return gameState != null
        ? GameStateModel.fromJson(json.decode(gameState))
        : null;
  }

  @override
  Future<void> saveGame({required GameStateModel gameState}) async {
    await localStorageService.set(
      'game_state',
      json.encode(gameState.toJson()),
    );
  }

  @override
  Future<void> clearGame() async {
    await localStorageService.remove('game_state');
  }
}

@Riverpod(keepAlive: true)
GameLocalDataSource gameLocalDataSource(Ref ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return GameLocalDataSourceImpl(localStorageService: localStorageService);
}
