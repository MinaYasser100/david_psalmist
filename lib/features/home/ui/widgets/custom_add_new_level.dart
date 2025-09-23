import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomAddNewLevel extends StatelessWidget {
  const CustomAddNewLevel({
    super.key,
    required this.title,
    this.onNegativeButtonPressed,
    this.onPositiveButtonPressed,
    required this.nameOfNegativeButton,
    required this.nameOfPositiveButton,
    required this.nameLevelController,
    required this.nameLevelFocusNode,
  });
  final String title;
  final void Function()? onNegativeButtonPressed;
  final void Function()? onPositiveButtonPressed;
  final String nameOfNegativeButton;
  final String nameOfPositiveButton;

  final TextEditingController nameLevelController;
  final FocusNode nameLevelFocusNode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsTheme().whiteColor,
      title: Text(
        title,
        style: AppTextStyles.styleMedium24sp(
          context,
        ).copyWith(color: ColorsTheme().primaryDark),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: nameLevelController,
              labelText: "Name of Level",
              hintText: "Enter your name",
              icon: Icons.layers_rounded,
              keyboardType: TextInputType.text,
              validator: (value) => null,
              autofocus: true,
              focusNode: nameLevelFocusNode,
              onFieldSubmitted: (value) {
                nameLevelFocusNode.unfocus();
              },
            ),
          ),
        ],
      ),

      actions: [
        _customAlertButton(
          context,
          text: nameOfNegativeButton,
          onPressed: onNegativeButtonPressed,
        ),
        _customAlertButton(
          context,
          text: nameOfPositiveButton,
          onPressed: onPositiveButtonPressed,
        ),
      ],
    );
  }

  TextButton _customAlertButton(
    BuildContext context, {
    required String text,
    void Function()? onPressed,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorsTheme().primaryDark, width: 2),
        ),
        backgroundColor: ColorsTheme().primaryDark,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.styleBold18sp(
          context,
        ).copyWith(color: ColorsTheme().whiteColor),
      ),
    );
  }
}
