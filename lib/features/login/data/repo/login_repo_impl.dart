import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/caching/shared/shared_perf_helper.dart';
import 'package:david_psalmist/core/firebase/firebase_auth_error_handling.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepoImpl implements LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthErrorHandling errorHandling;
  final SharedPrefHelper _sharedPrefHelper;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserHiveHelper userHiveHelper;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;

  LoginRepoImpl({
    required this.errorHandling,
    required SharedPrefHelper sharedPrefHelper,
    required this.userHiveHelper,
    required this.firestoreErrorHandler,
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

      await _fetchAndStoreUserInfo(user.user!.uid);
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

      final User? currentUser = _auth.currentUser; // التحقق من المستخدم الحالي
      UserCredential? userCredential;

      if (currentUser != null) {
        // حالة ربط الحساب (link) إذا كان مسجل بطريقة تانية
        try {
          userCredential = await currentUser.linkWithCredential(credential);
        } on FirebaseAuthException catch (linkError) {
          if (linkError.code == 'provider-already-linked') {
            // لو كان Google متربط بالفعل، نستخدم الحساب الحالي مباشرة
            userCredential = null; // ما نحتاجش UserCredential جديد
          } else {
            return Left(linkError.message ?? 'Failed to link Google account');
          }
        }
      } else {
        // حالة تسجيل دخول جديد
        userCredential = await _auth.signInWithCredential(credential);
      }

      final User? user =
          userCredential?.user ??
          currentUser; // نختار المستخدم بناءً على الحالة
      if (user != null) {
        await _sharedPrefHelper.saveBool(ConstantVariable.isLogin, true);
        await _registerAndSaveUserGoogleInfo(user); // حفظ البيانات
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

  Future<void> _registerAndSaveUserGoogleInfo(User user) async {
    UserModel userModel = UserModel(
      email: user.email!,
      firstName: user.displayName!.split(' ')[0],
      lastName: user.displayName!.split(' ')[1],
      uid: user.uid,
    );
    await _registerUserInfoInFirebase(userModel: userModel);
    await userHiveHelper.saveUser(userModel);
  }

  Future<void> _fetchAndStoreUserInfo(String uid) async {
    try {
      final docSnapshot = await _firestore
          .collection(ConstantVariable.users)
          .doc(uid)
          .get();
      if (docSnapshot.exists) {
        final userModel = UserModel.fromMap(docSnapshot.data()!);
        await userHiveHelper.saveUser(userModel);
      } else {
        log('No user data found in Firestore for uid: $uid');
      }
    } catch (e) {
      log('Error fetching user info: $e');
    }
  }

  Future<Either<String, void>> _registerUserInfoInFirebase({
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
