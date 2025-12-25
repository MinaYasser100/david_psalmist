import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentSubmitButton extends StatelessWidget {
  const AddStudentSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorsTheme().primaryDark,
              ),
            )
          : CustomButton(text: 'Add Student'.tr(), onPressed: onPressed),
    );
  }
}
