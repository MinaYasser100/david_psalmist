import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomNoLevelsWidget extends StatelessWidget {
  const CustomNoLevelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          'No levels found, add new level'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.styleBold24sp(
            context,
          ).copyWith(color: ColorsTheme().grayWhite),
        ),
      ),
    );
  }
}
