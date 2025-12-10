import 'package:flutter/material.dart';
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
        return MaterialPageRoute(builder: (_) => const MenuView());
      case gameRoute:
        return MaterialPageRoute(builder: (_) => const GameView());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
