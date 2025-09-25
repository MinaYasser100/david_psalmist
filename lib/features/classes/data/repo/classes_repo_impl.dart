import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/utils/constant.dart';

import 'package:david_psalmist/features/classes/data/model/class_model.dart';

import 'classes_repo.dart';

class ClassesRepoImpl implements ClassesRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestoreErrorHandler _firebaseFirestoreErrorHandler;

  ClassesRepoImpl(this._firebaseFirestoreErrorHandler);
  @override
  Future<Either<String, void>> addClass(ClassModel classModel) async {
    try {
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(classModel.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(classModel.id)
          .set(classModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        _firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
      );
    } catch (e) {
      return const Left('Failed to add class');
    }
  }

  @override
  Future<Either<String, void>> deleteClass({
    required ClassModel classModel,
  }) async {
    try {
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(classModel.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(classModel.id)
          .delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        _firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
      );
    } catch (e) {
      return const Left('Failed to delete class');
    }
  }

  @override
  Stream<List<ClassModel>> getClasses({required String levelId}) {
    return _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(levelId)
        .collection(ConstantVariable.classesCollection)
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            final data = doc.data();
            return ClassModel(id: doc.id, name: data['name'], levelId: levelId);
          }).toList();
        });
  }

  @override
  Future<Either<String, void>> updateClass(ClassModel classModel) async {
    try {
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(classModel.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(classModel.id)
          .update(classModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        _firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
      );
    } catch (e) {
      return const Left('Failed to update class');
    }
  }
}



  // Future<Either<String, List<ClassModel>>> getClassesOnce({
  //   required String levelId,
  // }) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection(ConstantVariable.levelsCollection)
  //         .doc(levelId)
  //         .collection(ConstantVariable.classesCollection)
  //         .get();
  //     final classes = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return ClassModel.fromMap(data);
  //     }).toList();
  //     return Right(classes);
  //   } on FirebaseException catch (e) {
  //     return Left(
  //       _firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
  //     );
  //   } catch (e) {
  //     return const Left('Failed to fetch classes');
  //   }
  // }