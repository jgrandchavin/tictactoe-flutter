import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_flutter/core/router/router.dart';

import 'core/utils/logger.dart';

void main() async {
  log.d('[MAIN] Starting app...');
  WidgetsFlutterBinding.ensureInitialized();

  log.d('[MAIN] Setting preferred orientations to portrait');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(child: const TicTacToeApp()));
}

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(routerProvider),
    );
  }
}
