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
