import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchSelectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchSelectionAppBar({
    super.key,
    required this.selectedCount,
    required this.totalCount,
    required this.isSubmitting,
    required this.onClose,
    required this.onToggleSelectAll,
    required this.onSubmit,
  });

  final int selectedCount;
  final int totalCount;
  final bool isSubmitting;
  final VoidCallback onClose;
  final VoidCallback onToggleSelectAll;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '$selectedCount',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: onClose,
      ),
      actions: [
        TextButton.icon(
          onPressed: onToggleSelectAll,
          icon: Icon(
            selectedCount == totalCount ? Icons.remove_done : Icons.done_all,
            size: 20,
            color: Colors.white,
          ),
          label: Text(
            selectedCount == totalCount ? 'Clear'.tr() : 'All'.tr(),
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
              onPressed: isSubmitting ? null : onSubmit,
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
              child: isSubmitting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
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
