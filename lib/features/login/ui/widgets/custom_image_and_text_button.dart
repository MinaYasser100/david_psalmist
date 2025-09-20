import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomImageAndTextButton extends StatelessWidget {
  const CustomImageAndTextButton({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
  });
  final String image;
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsTheme().primaryDark,
          padding: EdgeInsets.all(0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(image),
              backgroundColor: ColorsTheme().cardColor,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(text, style: AppTextStyles.styleBold16sp(context)),
            ),
          ],
        ),
      ),
    );
  }
}
