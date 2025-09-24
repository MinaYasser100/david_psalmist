import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:flutter/material.dart';

class CustomLevelItemView extends StatelessWidget {
  const CustomLevelItemView({
    super.key,
    required this.level,
    required this.index,
  });

  final LevelModel level;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme().primaryDark,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        textColor: ColorsTheme().whiteColor,
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: ColorsTheme().secondaryColor,
          child: Text(
            '${index + 1}',
            style: AppTextStyles.styleBold24sp(
              context,
            ).copyWith(color: ColorsTheme().whiteColor),
          ),
        ),
        title: Text(level.name, style: AppTextStyles.styleBold24sp(context)),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.arrow_forward_ios, color: ColorsTheme().whiteColor),
        ),
      ),
    );
  }
}
