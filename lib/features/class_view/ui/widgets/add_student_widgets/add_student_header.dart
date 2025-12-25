import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentHeader extends StatelessWidget {
  const AddStudentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drag Handle
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: ColorsTheme().grayWhite,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        // Title
        Text(
          'Add New Student'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsTheme().primaryDark,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
