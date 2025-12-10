import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/features/game/domain/entities/game_state.dart';
import 'package:tictactoe_flutter/features/game/presentation/views/game_view.dart';
import 'package:tictactoe_flutter/features/menu/presentation/views/menu_view.dart';
import 'package:tictactoe_flutter/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const splashRoute = '/';
  static const menuRoute = '/menu';
  static const gameRoute = '/game';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return _fadeRoute(const SplashView(), settings);
      case menuRoute:
        final savedGame = settings.arguments as GameState?;
        return _fadeRoute(MenuView(savedGame: savedGame), settings);
      case gameRoute:
        final savedGame = settings.arguments as GameState?;
        return _fadeRoute(GameView(savedGame: savedGame), settings);
      default:
        return _fadeRoute(
          const Scaffold(body: Center(child: Text('Route not found'))),
          settings,
        );
    }
  }

  static PageRoute _fadeRoute(Widget child, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        final fade = FadeTransition(opacity: curved, child: child);
        final scale = Tween<double>(begin: 0.96, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );
        return ScaleTransition(scale: scale, child: fade);
      },
    );
  }
}
