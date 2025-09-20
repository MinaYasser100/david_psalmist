import 'package:david_psalmist/features/verfiy_email/data/repo/verify_email_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this._verfiyEmailRepo) : super(VerifyEmailInitial());

  final VerfiyEmailRepo _verfiyEmailRepo;

  // التحقق من حالة البريد الإلكتروني
  Future<void> checkEmailVerification() async {
    final isVerified = await _verfiyEmailRepo.isEmailVerified();
    if (isVerified) {
      emit(VerifyEmailSuccess());
    } else {
      emit(VerifyEmailWaiting());
    }
  }

  // إعادة إرسال رابط التحقق
  Future<void> resendVerificationEmail() async {
    try {
      emit(VerifyEmailLoading());
      await _verfiyEmailRepo.resendVerificationEmail();
      emit(
        VerifyEmailWaiting(
          message: 'Verification email resent. Please check your inbox.',
        ),
      );
    } catch (e) {
      emit(VerifyEmailError(error: e.toString()));
    }
  }

  void startVerificationCheck() {
    const duration = Duration(seconds: 3);
    Future.doWhile(() async {
      await checkEmailVerification();
      await Future.delayed(duration);
      return !FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }
}
