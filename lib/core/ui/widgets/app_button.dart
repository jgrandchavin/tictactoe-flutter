import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/ui/app_colors.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
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
        child: AppText.button(text: text.toUpperCase()),
      ),
    );
  }
}
