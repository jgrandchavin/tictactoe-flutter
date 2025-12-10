import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/core/design/app_colors.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final FontWeight fontWeight;
  final double fontSize;
  final FontStyle? fontStyle;

  const AppText({
    super.key,
    required this.text,
    required this.textAlign,
    required this.color,
    required this.overflow,
    required this.fontWeight,
    required this.fontSize,
    required this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? AppColors.white,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontFamily: 'Nunito',
      ),
      overflow: overflow,
    );
  }

  factory AppText.custom({
    required String text,
    required TextAlign textAlign,
    required Color color,
    required TextOverflow overflow,
    required FontWeight fontWeight,
    required double fontSize,
    required FontStyle fontStyle,
  }) => AppText(
    text: text,
    textAlign: textAlign,
    color: color,
    overflow: overflow,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: fontStyle,
  );

  factory AppText.body({
    required String text,
    TextAlign textAlign = TextAlign.center,
    Color color = AppColors.white,
    TextOverflow overflow = TextOverflow.ellipsis,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
  }) => AppText(
    text: text,
    textAlign: textAlign,
    color: color,
    overflow: overflow,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: fontStyle,
  );

  factory AppText.button({
    required String text,
    TextAlign textAlign = TextAlign.center,
    Color color = AppColors.white,
    TextOverflow overflow = TextOverflow.ellipsis,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 18,
    FontStyle fontStyle = FontStyle.normal,
  }) => AppText(
    text: text,
    textAlign: textAlign,
    color: color,
    overflow: overflow,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: fontStyle,
  );
}
