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
      duration: Duration(milliseconds: 300 + (index * 50)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsTheme().primaryDark.withValues(alpha: 0.05),
              ColorsTheme().primaryDark.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: ColorsTheme().primaryDark.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            // circular icon with index
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    ColorsTheme().primaryColor,
                    ColorsTheme().primaryDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsTheme().primaryDark.withValues(alpha: 0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.styleBold24sp(
                    context,
                  ).copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // title and subtitle
            Expanded(
              child: Text(
                level.name,
                style: AppTextStyles.styleBold24sp(
                  context,
                ).copyWith(fontSize: 18, color: ColorsTheme().primaryDark),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: ColorsTheme().primaryDark.withValues(alpha: 0.7),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
