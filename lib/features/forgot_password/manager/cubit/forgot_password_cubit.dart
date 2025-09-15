import 'package:david_psalmist/features/forgot_password/data/repo/forgot_password_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPasswordRepo)
    : super(ForgotPasswordInitial());

  final ForgotPasswordRepo _forgotPasswordRepo;

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await _forgotPasswordRepo.sendPasswordResetEmail(
      email: email,
    );
    result.fold(
      (l) => emit(ForgotPasswordError(error: l)),
      (r) => emit(ForgotPasswordSuccess()),
    );
  }
}
