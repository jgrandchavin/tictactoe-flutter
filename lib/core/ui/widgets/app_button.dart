import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/ui/app_colors.dart';
import 'package:tictactoe_flutter/core/ui/widgets/app_text.dart';
import 'package:tictactoe_flutter/core/utils/haptics_utils.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool allWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.allWidth = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  static const double _shadowOffsetY = 8.0;
  static const Duration _animationDuration = Duration(milliseconds: 100);

  bool _isPressed = false;

  void _press() {
    if (!mounted) return;
    setState(() => _isPressed = true);
    HapticsUtils.medium();
  }

  void _release() {
    if (!mounted) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onHighlightChanged: (isDown) {
          if (isDown) {
            _press();
          } else {
            _release();
          }
        },
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            widget.onPressed();
            HapticsUtils.selectionClick();
          });
        },
        child: AnimatedContainer(
          duration: _animationDuration,
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          margin: const EdgeInsets.only(bottom: 8),
          width: widget.allWidth ? double.infinity : null,
          transform: _isPressed
              ? Matrix4.translationValues(0, _shadowOffsetY, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isPressed
                ? const []
                : const [
                    BoxShadow(
                      color: AppColors.secondary,
                      blurRadius: 0,
                      offset: Offset(0, _shadowOffsetY),
                    ),
                  ],
          ),
          child: AppText.button(text: widget.text.toUpperCase()),
        ),
      ),
    );
  }
}
