import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScannedStudentsHeader extends StatelessWidget {
  const ScannedStudentsHeader({super.key, required this.studentsCount});

  final int studentsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            Icons.people_alt_rounded,
            color: ColorsTheme().primaryColor,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'scanned_students'.tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsTheme().primaryDark,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorsTheme().primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$studentsCount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorsTheme().primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
