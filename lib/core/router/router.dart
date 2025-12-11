import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/router/routes.dart';
import 'package:tictactoe_flutter/features/game/presentation/views/game_view.dart';
import 'package:tictactoe_flutter/features/menu/presentation/views/menu_view.dart';
import 'package:tictactoe_flutter/features/splash/presentation/views/splash_view.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) =>
            _buildFadeTransitionPage(const SplashView(), state),
      ),
      GoRoute(
        path: Routes.menu,
        name: Routes.menu,
        pageBuilder: (context, state) =>
            _buildFadeTransitionPage(const MenuView(), state),
      ),
      GoRoute(
        path: Routes.game,
        name: Routes.game,
        pageBuilder: (context, state) =>
            _buildFadeTransitionPage(GameView(savedGame: null), state),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
  );
}

CustomTransitionPage<void> _buildFadeTransitionPage(
  Widget child,
  GoRouterState state,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
