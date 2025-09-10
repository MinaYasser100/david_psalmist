import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class MinimalErrorWidget extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const MinimalErrorWidget({super.key, required this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off, color: ColorsTheme().errorColor, size: 60),
          const SizedBox(height: 10),
          Text(
            'Error Occurred',
            style: AppTextStyles.styleBold22sp(
              context,
            ).copyWith(color: ColorsTheme().errorColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleRegular18sp(
              context,
            ).copyWith(color: ColorsTheme().errorColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Try Again, later...',
            style: AppTextStyles.styleRegular18sp(
              context,
            ).copyWith(color: ColorsTheme().errorColor),
          ),
        ],
      ),
    );
  }
}
