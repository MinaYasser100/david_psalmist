import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScannerOptionsBottomSheet extends StatelessWidget {
  const ScannerOptionsBottomSheet({
    super.key,
    required this.onSingleScan,
    required this.onBatchScan,
  });

  final VoidCallback onSingleScan;
  final VoidCallback onBatchScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.qr_code_scanner,
              color: ColorsTheme().primaryColor,
            ),
            title: Text('Single Scan'.tr()),
            subtitle: Text('Record one student at a time'.tr()),
            onTap: () {
              Navigator.pop(context);
              onSingleScan();
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.qr_code_2, color: ColorsTheme().primaryColor),
            title: Text('Batch Scan'.tr()),
            subtitle: Text('Scan multiple students and submit together'.tr()),
            onTap: () {
              Navigator.pop(context);
              onBatchScan();
            },
          ),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required VoidCallback onSingleScan,
    required VoidCallback onBatchScan,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScannerOptionsBottomSheet(
        onSingleScan: onSingleScan,
        onBatchScan: onBatchScan,
      ),
    );
  }
}
