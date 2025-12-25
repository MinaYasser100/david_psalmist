import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentBirthdayPsalmist extends StatelessWidget {
  const AddStudentBirthdayPsalmist({
    super.key,
    required this.selectedBirthday,
    required this.isPsalmist,
    required this.onBirthdayTap,
    required this.onPsalmistChanged,
  });

  final DateTime? selectedBirthday;
  final bool isPsalmist;
  final VoidCallback onBirthdayTap;
  final ValueChanged<bool> onPsalmistChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Birthday Picker
        InkWell(
          onTap: onBirthdayTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsTheme().primaryDark),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.cake, color: ColorsTheme().primaryDark),
                const SizedBox(width: 12),
                Text(
                  selectedBirthday == null
                      ? 'Select Birthday'.tr()
                      : DateFormat('dd/MM/yyyy').format(selectedBirthday!),
                  style: TextStyle(
                    color: selectedBirthday == null
                        ? ColorsTheme().grayWhite
                        : ColorsTheme().primaryDark,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Is Psalmist Checkbox
        Row(
          children: [
            Checkbox(
              value: isPsalmist,
              onChanged: (value) => onPsalmistChanged(value ?? false),
              activeColor: ColorsTheme().primaryDark,
            ),
            Text(
              'Is Psalmist'.tr(),
              style: TextStyle(color: ColorsTheme().primaryDark, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
