import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class NormalModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NormalModeAppBar({
    super.key,
    required this.title,
    required this.onSearch,
    required this.onAdd,
    required this.onEnableSelection,
  });

  final String title;
  final VoidCallback onSearch;
  final VoidCallback onAdd;
  final VoidCallback onEnableSelection;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        _CustomActionButton(onPressed: onSearch, icon: Icons.search),
        _CustomActionButton(onPressed: onAdd, icon: Icons.add),
        _CustomActionButton(
          onPressed: onEnableSelection,
          icon: Icons.checklist,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomActionButton extends StatelessWidget {
  const _CustomActionButton({required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsTheme().whiteColor,
        ),
        child: Icon(icon, color: ColorsTheme().primaryDark),
      ),
    );
  }
}
