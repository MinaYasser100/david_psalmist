import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepo {
  Future<Either<String, void>> sendPasswordResetEmail({required String email});
}
