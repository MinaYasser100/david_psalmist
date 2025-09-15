import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forgot_password_repo.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final FirebaseAuthErrorHandling _errorHandling;
  final _auth = FirebaseAuth.instance;
  ForgotPasswordRepoImpl(this._errorHandling);
  @override
  Future<Either<String, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      log('Attempting to send password reset email to: $email');

      // Remove any whitespace from the email
      final trimmedEmail = email.trim();

      // Basic email validation
      if (!trimmedEmail.contains('@') || !trimmedEmail.contains('.')) {
        return const Left('Please enter a valid email address');
      }

      await _auth.sendPasswordResetEmail(email: trimmedEmail);

      log('Password reset email sent successfully to $email');
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          return const Left('No user found with this email address');
        case 'invalid-email':
          return const Left('The email address is not valid');
        case 'missing-android-pkg-name':
          log('Error: Missing Android package name in configuration');
          return const Left('App configuration error. Please contact support.');
        case 'missing-continue-uri':
          log('Error: Missing continue URL in configuration');
          return const Left('App configuration error. Please contact support.');
        case 'missing-ios-bundle-id':
          log('Error: Missing iOS bundle ID in configuration');
          return const Left('App configuration error. Please contact support.');
        case 'invalid-continue-uri':
          log('Error: Invalid continue URL in configuration');
          return const Left('App configuration error. Please contact support.');
        case 'unauthorized-continue-uri':
          log('Error: Unauthorized continue URL in configuration');
          return const Left('App configuration error. Please contact support.');
        default:
          return Left(_errorHandling.mapFirebaseAuthException(e));
      }
    } catch (e) {
      log('Unexpected error while sending reset email: ${e.toString()}');
      return const Left('Reset Password Process Failed');
    }
  }
}
