part of 'class_cubit.dart';

@immutable
sealed class ClassState {}

final class ClassInitial extends ClassState {}

final class ClassLoading extends ClassState {}

final class ClassAdded extends ClassState {}

final class ClassError extends ClassState {
  final String message;
  ClassError(this.message);
}

final class ClassDeleted extends ClassState {}

final class ClassUpdated extends ClassState {}

final class GetAllClassesSuccess extends ClassState {
  final List<ClassModel> classes;
  GetAllClassesSuccess({required this.classes});
}
