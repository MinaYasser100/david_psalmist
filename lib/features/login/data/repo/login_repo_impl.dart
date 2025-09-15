import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      await _sharedPrefHelper.saveString(ConstantVariable.uId, user.user!.uid);
      await _sharedPrefHelper.saveBool(ConstantVariable.isLogin, true);
      return Right(user.user!);
    } on FirebaseAuthException catch (e) {
      return Left(errorHandling.mapFirebaseAuthException(e));
    } catch (e) {
      log(e.toString());
      return const Left('Login Process Failed');
    }
  }
}
