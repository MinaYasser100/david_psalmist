import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:david_psalmist/features/class_view/data/repo/scanner_repo.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepo repo;

  ScannerCubit(this.repo) : super(ScannerInitial());

  Future<void> scanQRCode(MobileScannerController controller) async {
    emit(ScannerLoading());
    final result = await repo.scanQRCode(controller);
    result.fold(
      (error) => emit(ScannerError(error)),
      (scannedName) => emit(ScannerSuccess(scannedName)),
    );
  }

  /// Process a scanned code string coming from the UI's onDetect callback.
  ///
  /// This avoids creating a race between the UI's onDetect and repo-based
  /// controller subscriptions. If you later need to validate or lookup the
  /// scanned code (e.g. map to a user name), call repo methods here.
  void processScannedCode(String code) {
    if (code.isEmpty) return;
    emit(ScannerLoading());
    // For now we treat the scanned code as the scannedName. If additional
    // processing is required (e.g. repo lookup), do it here and emit
    // ScannerSuccess or ScannerError accordingly.
    emit(ScannerSuccess(code));
  }
}
