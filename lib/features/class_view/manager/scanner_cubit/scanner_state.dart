part of 'scanner_cubit.dart';

@immutable
sealed class ScannerState {}

final class ScannerInitial extends ScannerState {}

final class ScannerLoading extends ScannerState {}

final class ScannerSuccess extends ScannerState {
  final String scannedName;
  ScannerSuccess(this.scannedName);
}

final class ScannerError extends ScannerState {
  final String error;
  ScannerError(this.error);
}

final class ScannerProcessingAttendance extends ScannerState {}

final class ScannerAttendanceChecked extends ScannerState {
  final String message;

  ScannerAttendanceChecked({required this.message});
}

final class ScannerAttendanceError extends ScannerState {
  final String error;
  ScannerAttendanceError(this.error);
}

// Batch Attendance States
final class ScannerBatchMode extends ScannerState {
  final List<StudentModel> scannedStudents;
  ScannerBatchMode(this.scannedStudents);
}

final class ScannerBatchSubmitting extends ScannerState {}

final class ScannerBatchSuccess extends ScannerState {
  final String message;
  ScannerBatchSuccess(this.message);
}

final class ScannerBatchError extends ScannerState {
  final String error;
  ScannerBatchError(this.error);
}
