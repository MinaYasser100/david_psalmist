part of 'level_cubit.dart';

@immutable
sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoaded extends LevelState {}

final class LevelDeleted extends LevelState {}

final class LevelLoading extends LevelState {}

final class LevelError extends LevelState {
  final String error;

  LevelError(this.error);
}

final class LevelGetAllLevelsSuccess extends LevelState {
  final List<LevelModel> levels;

  LevelGetAllLevelsSuccess(this.levels);
}

final class LevelGetAllLevelsLoading extends LevelState {}

final class LevelGetAllLevelsError extends LevelState {
  final String error;

  LevelGetAllLevelsError(this.error);
}
