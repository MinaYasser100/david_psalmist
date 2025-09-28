part of 'class_cubit.dart';

@immutable
sealed class ClassesState {}

final class ClassInitial extends ClassesState {}

final class ClassLoading extends ClassesState {}

final class ClassAdded extends ClassesState {}

final class ClassError extends ClassesState {
  final String message;
  ClassError(this.message);
}

final class ClassDeleted extends ClassesState {}

final class ClassUpdated extends ClassesState {}

final class GetAllClassesSuccess extends ClassesState {
  final List<ClassModel> classes;
  GetAllClassesSuccess({required this.classes});
}
