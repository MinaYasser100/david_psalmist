part of 'students_class_cubit.dart';

@immutable
sealed class StudentsClassState {}

final class StudentsClassInitial extends StudentsClassState {}

final class StudentsClassLoading extends StudentsClassState {}

final class StudentsClassLoaded extends StudentsClassState {
  final List<StudentModel> students;
  StudentsClassLoaded({required this.students});
}

final class StudentsClassError extends StudentsClassState {
  final String message;
  StudentsClassError({required this.message});
}

// Selection Mode States
final class StudentsClassSelectionMode extends StudentsClassState {
  final List<StudentModel> students;
  final Set<String> selectedStudentIds;

  StudentsClassSelectionMode({
    required this.students,
    required this.selectedStudentIds,
  });
}

final class StudentsClassBatchAttendanceSubmitting extends StudentsClassState {}

final class StudentsClassBatchAttendanceSuccess extends StudentsClassState {
  final String message;
  StudentsClassBatchAttendanceSuccess({required this.message});
}

final class StudentsClassBatchAttendanceError extends StudentsClassState {
  final String message;
  StudentsClassBatchAttendanceError({required this.message});
}
