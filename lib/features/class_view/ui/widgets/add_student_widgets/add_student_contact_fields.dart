import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddStudentContactFields extends StatelessWidget {
  const AddStudentContactFields({
    super.key,
    required this.phoneNumberController,
    required this.parentNumberController,
    required this.fatherNameController,
    required this.addressController,
    required this.phoneNumberFocus,
    required this.parentNumberFocus,
    required this.fatherNameFocus,
    required this.addressFocus,
  });

  final TextEditingController phoneNumberController;
  final TextEditingController parentNumberController;
  final TextEditingController fatherNameController;
  final TextEditingController addressController;
  final FocusNode phoneNumberFocus;
  final FocusNode parentNumberFocus;
  final FocusNode fatherNameFocus;
  final FocusNode addressFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phone Number
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: phoneNumberController,
            labelText: 'Phone Number'.tr(),
            hintText: 'Enter phone number'.tr(),
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            focusNode: phoneNumberFocus,
            validator: (value) => null,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(parentNumberFocus),
          ),
        ),
        const SizedBox(height: 16),

        // Parent Number
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: parentNumberController,
            labelText: 'Parent Number'.tr(),
            hintText: 'Enter parent number'.tr(),
            keyboardType: TextInputType.phone,
            icon: Icons.phone_android,
            focusNode: parentNumberFocus,
            validator: (value) => null,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(fatherNameFocus),
          ),
        ),
        const SizedBox(height: 16),

        // Father Name
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: fatherNameController,
            labelText: 'Father Name'.tr(),
            hintText: 'Enter father name'.tr(),
            keyboardType: TextInputType.name,
            icon: Icons.face,
            focusNode: fatherNameFocus,
            validator: (value) => null,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(addressFocus),
          ),
        ),
        const SizedBox(height: 16),

        // Address
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: addressController,
            labelText: 'Address'.tr(),
            hintText: 'Enter address'.tr(),
            keyboardType: TextInputType.streetAddress,
            icon: Icons.location_on,
            focusNode: addressFocus,
            validator: (value) => null,
          ),
        ),
      ],
    );
  }
}
