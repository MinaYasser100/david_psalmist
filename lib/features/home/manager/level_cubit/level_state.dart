part of 'level_cubit.dart';

@immutable
sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoaded extends LevelState {}

final class LevelLoading extends LevelState {}

final class LevelError extends LevelState {
  final String error;

  LevelError(this.error);
}
