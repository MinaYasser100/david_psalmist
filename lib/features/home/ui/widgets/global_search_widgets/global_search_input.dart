import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GlobalSearchInput extends StatelessWidget {
  const GlobalSearchInput({
    super.key,
    required this.searchController,
    required this.searchFocusNode,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          hintText: "Search by student name".tr(),
          labelText: "Search".tr(),
          controller: searchController,
          autofocus: true,
          focusNode: searchFocusNode,
          keyboardType: TextInputType.text,
          icon: Icons.search,
          validator: (value) => null,
          onChanged: onSearchChanged,
        ),
      ),
    );
  }
}
