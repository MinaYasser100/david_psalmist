import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:david_psalmist/features/class_view/data/repo/scanner_repo.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepo _scannerRepo;
  final StudentRepo _studentRepo;
  ScannerCubit(this._scannerRepo, this._studentRepo) : super(ScannerInitial());

  Future<void> scanQRCode(MobileScannerController controller) async {
    emit(ScannerLoading());
    final result = await _scannerRepo.scanQRCode(controller);
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

  Future<void> checkStudentAttendance({
    required String studentName,
    required String levelName,
    required ClassModel classModel,
  }) async {
    emit(ScannerProcessingAttendance());
    final result = await _studentRepo.addStudentByQRCode(
      studentName: studentName,
      levelName: levelName,
      classModel: classModel,
    );
    result.fold(
      (error) => emit(ScannerAttendanceError(error)),
      (message) => emit(ScannerAttendanceChecked(message: message)),
    );
  }

  Future<void> addStudentByQRCode({
    required ClassModel classModel,
    required String studentName,
    required String levelName,
    String? sex,
    String? phoneNumber,
    String? parentNumber,
    String? address,
    DateTime? birthday,
    String? fatherName,
    bool? isPsalmist,
  }) async {
    emit(ScannerLoading());
    final result = await _studentRepo.addStudentByQRCode(
      classModel: classModel,
      studentName: studentName,
      levelName: levelName,
      sex: sex,
      phoneNumber: phoneNumber,
      parentNumber: parentNumber,
      address: address,
      birthday: birthday,
      fatherName: fatherName,
      isPsalmist: isPsalmist,
    );
    result.fold(
      (error) => emit(ScannerError(error)),
      (message) => emit(ScannerSuccess(message)),
    );
  }
}
