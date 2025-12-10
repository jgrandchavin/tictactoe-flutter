import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.custom(
          text: 'Tic '.toUpperCase(),
          textAlign: TextAlign.center,
          color: AppColors.white.withValues(alpha: 0.75),
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w900,
          fontSize: 50,
          fontStyle: FontStyle.normal,
        ),
        AppText.custom(
          text: 'Tac Toe'.toUpperCase(),
          textAlign: TextAlign.center,
          color: AppColors.white,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w900,
          fontSize: 50,
          fontStyle: FontStyle.normal,
        ),
      ],
    );
  }
}
