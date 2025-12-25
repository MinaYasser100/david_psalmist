import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentGenderField extends StatelessWidget {
  const AddStudentGenderField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender'.tr(),
        labelStyle: TextStyle(color: ColorsTheme().primaryDark),
        prefixIcon: Icon(Icons.wc, color: ColorsTheme().primaryDark),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsTheme().primaryDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsTheme().primaryDark, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsTheme().primaryDark),
        ),
        filled: true,
        fillColor: ColorsTheme().whiteColor,
      ),
      dropdownColor: ColorsTheme().whiteColor,
      style: TextStyle(color: ColorsTheme().primaryDark, fontSize: 16),
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: ColorsTheme().primaryDark,
      ),
      iconSize: 24,
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      items: [
        DropdownMenuItem(
          value: 'Male',
          child: Row(
            children: [
              Icon(Icons.male, color: ColorsTheme().primaryDark),
              const SizedBox(width: 12),
              Text('Male'.tr()),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'Female',
          child: Row(
            children: [
              Icon(Icons.female, color: ColorsTheme().primaryDark),
              const SizedBox(width: 12),
              Text('Female'.tr()),
            ],
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
