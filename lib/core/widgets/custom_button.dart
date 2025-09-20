import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsTheme().primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      ),
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.styleBold16sp(context)),
    );
  }
}
