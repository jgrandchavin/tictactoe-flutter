import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_button.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_logo.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_scaffold.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: AppLogo()),
          AppText.body(text: 'You have a game that is not finished'),
          const SizedBox(height: 4),
          AppButton(text: 'Continue Game', onPressed: () {}),
          const SizedBox(height: 16),
          AppButton(text: 'Start New Game', onPressed: () {}),
        ],
      ),
    );
  }
}
