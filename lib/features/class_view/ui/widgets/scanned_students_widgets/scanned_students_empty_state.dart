import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScannedStudentsEmptyState extends StatelessWidget {
  const ScannedStudentsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_scanner_rounded,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'no_students_scanned'.tr(),
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
