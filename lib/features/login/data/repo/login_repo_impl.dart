import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepoImpl implements LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthErrorHandling errorHandling;
  final SharedPrefHelper _sharedPrefHelper;

  LoginRepoImpl({
    required this.errorHandling,
    required SharedPrefHelper sharedPrefHelper,
  }) : _sharedPrefHelper = sharedPrefHelper;
  @override
  Future<Either<String, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _sharedPrefHelper.saveBool(ConstantVariable.isLogin, true);
      return Right(user.user!);
    } on FirebaseAuthException catch (e) {
      return Left(errorHandling.mapFirebaseAuthException(e));
    } catch (e) {
      log(e.toString());
      return const Left('Login Process Failed');
    }
  }

  @override
  Future<Either<String, User>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return const Left('Google Sign-In was canceled by the user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;
      if (user != null) {
        await _sharedPrefHelper.saveBool(ConstantVariable.isLogin, true);
        return Right(user);
      } else {
        return const Left('Google Sign-In failed: User is null');
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      return Left(e.message ?? 'Firebase Auth Error');
    } catch (e) {
      log('Unexpected error during Google Sign-In: $e');
      return const Left('Google Sign-In Process Failed');
    }
  }
}
