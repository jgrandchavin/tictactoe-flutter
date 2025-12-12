import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/entities/preloaded_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/mappers/preloaded_saved_game_info_mapper.dart';
import 'package:tictactoe_flutter/core/shared/preloaded_saved_game/providers/preloaded_saved_game_state.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

import '../../../utils/logger.dart';

part 'init_preloaded_saved_game.g.dart';

class InitPreloadedSavedGame {
  final GameRepository gameRepository;
  final PreloadedSavedGameState preloadedSavedGameState;

  InitPreloadedSavedGame({
    required this.gameRepository,
    required this.preloadedSavedGameState,
  });

  Future<PreloadedSavedGameInfo?> call() async {
    final savedGame = await gameRepository.getSavedGame();

    final preloadedSavedGameInfo = savedGame != null
        ? PreloadedSavedGameInfoMapper.fromDomain(savedGame)
        : null;

    preloadedSavedGameState.set(preloadedSavedGameInfo);
    log.d(
      '[PRELOADED_SAVED_GAME] Initialized preloaded saved game info: $preloadedSavedGameInfo',
    );
    return preloadedSavedGameInfo;
  }
}

@Riverpod(keepAlive: true)
InitPreloadedSavedGame initPreloadedSavedGame(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  final preloadedSavedGameState = ref.watch(
    preloadedSavedGameStateProvider.notifier,
  );

  return InitPreloadedSavedGame(
    gameRepository: gameRepository,
    preloadedSavedGameState: preloadedSavedGameState,
  );
}
