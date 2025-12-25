import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentNameFields extends StatelessWidget {
  const AddStudentNameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.firstNameFocus,
    required this.lastNameFocus,
    required this.onFirstNameSubmitted,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode firstNameFocus;
  final FocusNode lastNameFocus;
  final VoidCallback onFirstNameSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Name
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: firstNameController,
            labelText: 'First Name'.tr(),
            hintText: 'Enter first name'.tr(),
            keyboardType: TextInputType.name,
            icon: Icons.person,
            focusNode: firstNameFocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required'.tr();
              }
              return null;
            },
            onFieldSubmitted: (_) => onFirstNameSubmitted(),
          ),
        ),
        const SizedBox(height: 16),

        // Last Name
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: lastNameController,
            labelText: 'Last Name'.tr(),
            hintText: 'Enter last name'.tr(),
            keyboardType: TextInputType.name,
            icon: Icons.person_outline,
            focusNode: lastNameFocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required'.tr();
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
