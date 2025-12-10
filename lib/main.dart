import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_flutter/core/app_router.dart';
import 'package:tictactoe_flutter/core/providers/shared_preferences_provider.dart';

import 'core/utils/logger.dart';

void main() async {
  log.d('[MAIN] Starting app...');
  WidgetsFlutterBinding.ensureInitialized();

  log.d('[MAIN] Initializing Shared Preferences');
  final prefs = await SharedPreferences.getInstance();
  log.d('[MAIN] Shared Preferences initialized');

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const TicTacToeApp(),
    ),
  );
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splashRoute,
    );
  }
}
