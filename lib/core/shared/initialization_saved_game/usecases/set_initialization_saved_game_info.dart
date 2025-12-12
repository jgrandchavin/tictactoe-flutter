import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/mappers/initialization_saved_game_info_mapper.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/providers/initialization_saved_game_info_provider.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'set_initialization_saved_game_info.g.dart';

class SetInitializationSavedGameInfo {
  final GameRepository gameRepository;
  final InitializationSavedGameInfoState initializationSavedGameInfoState;

  SetInitializationSavedGameInfo({
    required this.gameRepository,
    required this.initializationSavedGameInfoState,
  });

  Future<InitializationSavedGameInfo?> call() async {
    final savedGameState = await gameRepository.getSavedGame();

    final initializationSavedGameInfo = savedGameState != null
        ? InitializationSavedGameInfoMapper.fromDomain(savedGameState)
        : null;

    initializationSavedGameInfoState.set(initializationSavedGameInfo);

    return initializationSavedGameInfo;
  }
}

@Riverpod(keepAlive: true)
SetInitializationSavedGameInfo setInitializationSavedGameInfo(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  final initializationSavedGameInfoState = ref.read(
    initializationSavedGameInfoStateProvider.notifier,
  );
  return SetInitializationSavedGameInfo(
    gameRepository: gameRepository,
    initializationSavedGameInfoState: initializationSavedGameInfoState,
  );
}
