import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepoImpl implements RegisterRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthErrorHandling errorHandling;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;

  RegisterRepoImpl({
    required this.errorHandling,
    required this.firestoreErrorHandler,
  });
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
      userCredential.user!.sendEmailVerification();
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(errorHandling.mapFirebaseAuthException(e));
    } catch (e) {
      log(e.toString());
      return const Left('Register Process Failed');
    }
  }

  @override
  Future<Either<String, void>> registerUserInfoInFirebase({
    required UserModel userModel,
  }) async {
    try {
      await _firestore
          .collection(ConstantVariable.users)
          .doc(userModel.uid)
          .set(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      log(e.toString());
      return const Left('Register Process Failed');
    }
  }
}
