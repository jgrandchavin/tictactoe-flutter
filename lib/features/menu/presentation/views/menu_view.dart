import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe_flutter/core/router/routes.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_button.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_logo.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_scaffold.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(alignment: Alignment.bottomCenter, child: AppLogo()),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                text: 'Start a 1V1 Game',
                onPressed: () {
                  if (!context.mounted) return;
                  context.pushReplacementNamed(Routes.game);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
