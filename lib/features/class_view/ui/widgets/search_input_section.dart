import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchInputSection extends StatelessWidget {
  const SearchInputSection({
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
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
      sliver: SliverToBoxAdapter(
        child: CustomTextFormField(
          textFieldModel: TextFieldModel(
            hintText: "Search by name".tr(),
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
      ),
    );
  }
}
