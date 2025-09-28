import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAnimatedTextKit extends StatelessWidget {
  const CustomAnimatedTextKit({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: AppTextStyles.styleBold20sp(
            context,
          ).copyWith(color: ColorsTheme().primaryDark),
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 100), // سرعة التكتبية
        ),
      ],
      totalRepeatCount: 1, // يعمل مرة واحدة
      displayFullTextOnTap: true, // عرض النص كامل لو ضغطت
      stopPauseOnTap: true, // توقف عند الضغط
    );
  }
}
