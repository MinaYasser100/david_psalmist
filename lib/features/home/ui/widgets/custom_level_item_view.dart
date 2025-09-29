import 'package:animate_do/animate_do.dart';
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
    return FadeInLeft(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsTheme().primaryDark,
              ColorsTheme().primaryDark,
              ColorsTheme().primaryDark,
              ColorsTheme().primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          textColor: ColorsTheme().whiteColor,
          title: Text(level.name, style: AppTextStyles.styleBold24sp(context)),
          trailing: SizedBox(
            width: 28,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: ColorsTheme().whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
