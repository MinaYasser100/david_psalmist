import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchNormalAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchNormalAppBar({super.key, required this.onEnableSelection});

  final VoidCallback onEnableSelection;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Search here...'.tr()),
      actions: [
        IconButton(
          icon: const Icon(Icons.checklist),
          onPressed: onEnableSelection,
          tooltip: 'Select Students'.tr(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
