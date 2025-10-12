part of 'attendance_cubit.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceLoaded extends AttendanceState {
  final List<AttendanceModel> attendanceRecords;
  AttendanceLoaded({required this.attendanceRecords});
}

final class AttendanceError extends AttendanceState {
  final String error;
  AttendanceError({required this.error});
}
