import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/entities/initialization_saved_game_info.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/mappers/initialization_saved_game_info_mapper.dart';
import 'package:tictactoe_flutter/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictactoe_flutter/features/game/domain/repositories/game_repository.dart';

part 'get_initialization_saved_game_info.g.dart';

class GetInitializationSavedGameInfo {
  final GameRepository gameRepository;

  GetInitializationSavedGameInfo({required this.gameRepository});

  Future<InitializationSavedGameInfo?> call() async {
    final savedGame = await gameRepository.getSavedGame();
    return savedGame != null
        ? InitializationSavedGameInfoMapper.fromDomain(savedGame)
        : null;
  }
}

@Riverpod(keepAlive: true)
GetInitializationSavedGameInfo getInitializationSavedGameInfo(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);

  return GetInitializationSavedGameInfo(gameRepository: gameRepository);
}
