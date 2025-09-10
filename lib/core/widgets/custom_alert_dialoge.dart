import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String nameOfPositiveButton;
  final String nameOfNegativeButton;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;
  final bool? isLoading;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed,
    required this.nameOfPositiveButton,
    required this.nameOfNegativeButton,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style:
            AppTextStyles.styleMedium16sp(context).copyWith(color: Colors.red),
      ),
      content: Text(
        content,
        style: AppTextStyles.styleRegular20sp(context)
            .copyWith(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: onNegativeButtonPressed,
          child: Text(
            nameOfNegativeButton,
            style: AppTextStyles.styleMedium14sp(context)
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: onPositiveButtonPressed,
          child: isLoading!
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  nameOfPositiveButton,
                  style: AppTextStyles.styleRegular20sp(context)
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}
