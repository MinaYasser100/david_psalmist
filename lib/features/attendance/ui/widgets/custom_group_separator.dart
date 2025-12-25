import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomGroupSeparator extends StatelessWidget {
  const CustomGroupSeparator({super.key, required this.groupByValue});
  final DateTime groupByValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeInUp(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 70,
              height: 2,
              color: ColorsTheme().primaryDark.withValues(alpha: 0.3),
            ),
            Text(
              _formatMonthYear(groupByValue),
              style: AppTextStyles.styleBold18sp(
                context,
              ).copyWith(color: ColorsTheme().primaryDark),
            ),
            Container(
              width: 70,
              height: 2,
              color: ColorsTheme().primaryDark.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'ar').format(date);
  }
}
