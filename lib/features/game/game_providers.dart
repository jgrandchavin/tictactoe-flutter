import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/providers/shared_preferences_provider.dart';
import 'package:tictactoe_flutter/features/game/data/datasources/game_local_datasource.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/get_saved_game.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/make_move.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/start_new_game.dart';

// Data Source
final gameLocalDataSourceProvider = Provider<GameLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GameLocalDataSourceImpl(prefs: prefs);
});

// Repository
final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final local = ref.watch(gameLocalDataSourceProvider);
  return GameRepositoryImpl(gameLocalDataSource: local);
});

// Usecases
final startNewGameUsecaseProvider = Provider<StartNewGame>((ref) {
  final repository = ref.watch(gameRepositoryProvider);
  return StartNewGame(gameRepository: repository);
});

final makeMoveUsecaseProvider = Provider<MakeMove>((ref) {
  final repository = ref.watch(gameRepositoryProvider);
  return MakeMove(gameRepository: repository);
});

final getSavedGameUsecaseProvider = Provider<GetSavedGame>((ref) {
  final repository = ref.watch(gameRepositoryProvider);
  return GetSavedGame(gameRepository: repository);
});
