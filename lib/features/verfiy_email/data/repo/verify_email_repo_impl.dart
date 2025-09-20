import 'dart:developer';

import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'verify_email_repo.dart';

class VerifyEmailRepoImpl implements VerfiyEmailRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthErrorHandling errorHandling;

  VerifyEmailRepoImpl({required this.errorHandling});

  @override
  Future<bool> isEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      log('Error checking email verification: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> resendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      log('Error resending verification email: ${e.message}');
      throw Exception('Error resending verification email');
    }
  }
}
