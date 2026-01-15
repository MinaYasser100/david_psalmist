part of 'global_search_cubit.dart';

@immutable
sealed class GlobalSearchState {}

final class GlobalSearchInitial extends GlobalSearchState {}

final class GlobalSearchLoading extends GlobalSearchState {}

final class GlobalSearchLoaded extends GlobalSearchState {
  final List<StudentModel> students;
  GlobalSearchLoaded(this.students);
}

final class GlobalSearchError extends GlobalSearchState {
  final String message;
  GlobalSearchError(this.message);
}
