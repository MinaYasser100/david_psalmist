import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRepo {
  Future<Either<String, User>> egisterWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<String, void>> registerUserInfoInFirebase({
    required UserModel userModel,
  });
}
