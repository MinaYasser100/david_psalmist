import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepoImpl implements RegisterRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthErrorHandling errorHandling;

  RegisterRepoImpl({required this.errorHandling});
  @override
  Future<Either<String, User>> egisterWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(errorHandling.mapFirebaseAuthException(e));
    } catch (e) {
      log(e.toString());
      return const Left('Register Process Failed');
    }
  }
}
