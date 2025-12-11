import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/providers/local_storage_service_provider.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/domain/usecases/get_saved_game.dart';
import 'package:tictactoe_flutter/features/splash/presentation/controllers/splash_view_state.dart';

import '../../../../core/utils/logger.dart';

part 'splash_view_controller.g.dart';

@riverpod
class SplashViewController extends _$SplashViewController {
  bool _initialized = false;
  DateTime? _startTime;
  static const Duration _minSplashDuration = Duration(seconds: 2);

  @override
  SplashViewState build() {
    initialize();
    return SplashViewState(isLoading: true);
  }

  void initialize() async {
    if (!_initialized) {
      _initialized = true;
      _startTime = DateTime.now();
      Future.microtask(_startAsyncInit);
    }
  }

  Future<void> _startAsyncInit() async {
    try {
      log.d('[SPLASH] Initializing local storage service');
      await ref.read(localStorageServiceProvider).initialize();

      log.d('[SPLASH] Checking saved game');
      final savedGame = await checkSavedGame();

      await _ensureMinDuration();
      state = state.copyWith(isLoading: false, savedGame: savedGame);
    } catch (e) {
      log.e('Error checking saved game', error: e);
      await _ensureMinDuration();
      state = state.copyWith(isLoading: false);
    }
  }

  Future<GameState?> checkSavedGame() async {
    try {
      return await ref.read(getSavedGameUsecaseProvider).call();
    } catch (e) {
      log.e('Error reading saved game', error: e);
      return null;
    }
  }

  Future<void> _ensureMinDuration() async {
    final start = _startTime ?? DateTime.now();
    final elapsed = DateTime.now().difference(start);
    final remaining = _minSplashDuration - elapsed;
    if (remaining > Duration.zero) {
      await Future.delayed(remaining);
    }
  }
}
