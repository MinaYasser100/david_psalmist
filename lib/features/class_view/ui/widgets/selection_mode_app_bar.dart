import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectionModeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SelectionModeAppBar({
    super.key,
    required this.selectedCount,
    required this.totalStudents,
    required this.onClose,
    required this.onSelectAll,
    required this.onDeselectAll,
    required this.onSubmit,
  });

  final int selectedCount;
  final int totalStudents;
  final VoidCallback onClose;
  final VoidCallback onSelectAll;
  final VoidCallback onDeselectAll;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: onClose,
      ),
      title: Text(
        '$selectedCount',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: selectedCount == totalStudents
              ? onDeselectAll
              : onSelectAll,
          icon: Icon(
            selectedCount == totalStudents ? Icons.remove_done : Icons.done_all,
            size: 20,
            color: Colors.white,
          ),
          label: Text(
            selectedCount == totalStudents ? 'Clear'.tr() : 'All'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (selectedCount > 0) ...[
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ColorsTheme().primaryColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
