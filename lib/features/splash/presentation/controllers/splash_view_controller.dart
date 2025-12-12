import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/providers/local_storage_service_provider.dart';
import 'package:tictactoe_flutter/core/shared/initialization_saved_game/usecases/get_initialization_saved_game_info.dart';
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
    return SplashViewState(isLoading: true, initializationSavedGameInfo: null);
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

      log.d('[SPLASH] Checking initialization saved game info');

      final initializationSavedGameInfo = await ref
          .read(getInitializationSavedGameInfoProvider)
          .call();

      // NOTE: This is to ensure the splash screen is displayed for at least _minSplashDuration seconds.
      await _ensureMinDuration();

      state = state.copyWith(
        isLoading: false,
        initializationSavedGameInfo: initializationSavedGameInfo,
      );
    } catch (e) {
      log.e('Error checking saved game', error: e);
      await _ensureMinDuration();
      state = state.copyWith(isLoading: false);
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
