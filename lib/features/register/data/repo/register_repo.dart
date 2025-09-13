import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRepo {
  Future<Either<String, User>> egisterWithEmailAndPassword({
    required String email,
    required String password,
  });
}
