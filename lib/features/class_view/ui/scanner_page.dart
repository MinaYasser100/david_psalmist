import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({
    super.key,
    required this.classModel,
    required this.levelName,
  });
  final ClassModel classModel;
  final String levelName;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late final MobileScannerController _controller;
  bool _scanned = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return; // prevent multiple scans
    if (capture.barcodes.isEmpty) return;

    final code = capture.barcodes.first.rawValue ?? '';
    if (code.isEmpty) return;

    _scanned = true;

    // notify Cubit (optional for logging or further processing)
    if (context.read<ScannerCubit>().state is! ScannerLoading) {
      context.read<ScannerCubit>().processScannedCode(code);
    }

    Future.delayed(const Duration(milliseconds: 500), () async {
      await context.read<ScannerCubit>().checkStudentAttendance(
        studentName: code,
        levelName: widget.levelName,
        classModel: widget.classModel,
      );
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: Text('Scan QR Code'.tr()),
        actions: [
          IconButton(
            onPressed: () => _controller.toggleTorch(),
            icon: const Icon(Icons.flash_on),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Place the QR code inside the area to scan it".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorsTheme().whiteColor),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'cancel'.tr(),
                    style: AppTextStyles.styleBold20sp(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
