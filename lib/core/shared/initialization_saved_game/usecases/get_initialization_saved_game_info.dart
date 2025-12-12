import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/providers/initialization_saved_game_info_provider.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'get_initialization_saved_game_info.g.dart';

class GetInitializationSavedGameInfo {
  final GameRepository gameRepository;
  final InitializationSavedGameInfoState initializationSavedGameInfoState;

  GetInitializationSavedGameInfo({
    required this.gameRepository,
    required this.initializationSavedGameInfoState,
  });

  InitializationSavedGameInfo? call() {
    return initializationSavedGameInfoState.get() ?? null;
  }
}

@Riverpod(keepAlive: true)
GetInitializationSavedGameInfo getInitializationSavedGameInfo(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  final initializationSavedGameInfoState = ref.read(
    initializationSavedGameInfoStateProvider.notifier,
  );

  return GetInitializationSavedGameInfo(
    gameRepository: gameRepository,
    initializationSavedGameInfoState: initializationSavedGameInfoState,
  );
}
