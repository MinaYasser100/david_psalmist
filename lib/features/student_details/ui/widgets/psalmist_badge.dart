import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PsalmistBadge extends StatelessWidget {
  const PsalmistBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return BounceInDown(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.primaryColor.withValues(alpha: 0.2),
              theme.primaryDark.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryDark.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, size: 18, color: theme.primaryDark),
            const SizedBox(width: 6),
            Text(
              'psalmist'.tr(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
