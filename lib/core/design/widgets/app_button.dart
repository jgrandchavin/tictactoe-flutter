import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';
import 'package:tictactoe_flutter/core/design/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary,
            blurRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: AppText.button(text: text),
    );
  }
}
