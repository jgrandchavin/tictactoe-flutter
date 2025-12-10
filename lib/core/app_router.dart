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
        return MaterialPageRoute(builder: (_) => const SplashView());
      case menuRoute:
        final savedGame = settings.arguments as GameState?;
        return MaterialPageRoute(
          builder: (_) => MenuView(savedGame: savedGame),
        );
      case gameRoute:
        final savedGame = settings.arguments as GameState?;
        return MaterialPageRoute(
          builder: (_) => GameView(savedGame: savedGame),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
