part of 'verify_email_cubit.dart';

@immutable
sealed class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

final class VerifyEmailLoading extends VerifyEmailState {}

final class VerifyEmailSuccess extends VerifyEmailState {}

final class VerifyEmailError extends VerifyEmailState {
  final String error;
  VerifyEmailError({required this.error});
}

final class VerifyEmailWaiting extends VerifyEmailState {
  final String? message;
  VerifyEmailWaiting({this.message});
}
