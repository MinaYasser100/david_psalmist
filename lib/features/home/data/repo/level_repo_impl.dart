import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';

import 'level_repo.dart';

class LevelRepoImpl implements LevelRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestoreErrorHandler firebaseFirestoreErrorHandler;

  LevelRepoImpl(this.firebaseFirestoreErrorHandler);

  @override
  @override
  Future<Either<String, void>> addLevel(LevelModel level) async {
    try {
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(level.id)
          .set(level.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
      );
    } catch (e) {
      return const Left('Failed to add level');
    }
  }

  @override
  Future<Either<String, void>> deleteLevel({required String levelId}) async {
    try {
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(levelId)
          .delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e),
      );
    } catch (e) {
      return const Left('Failed to delete level');
    }
  }

  @override
  Stream<List<LevelModel>> getLevels() {
    return _firestore
        .collection(ConstantVariable.levelsCollection)
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            final data = doc.data();
            return LevelModel(id: doc.id, name: data['name']);
          }).toList();
        });
  }
}

// Future<Either<String, List<LevelModel>>> getLevels() async {
//   try {
//     return _firestore.collection(ConstantVariable.levelsCollection).get().then((
//       querySnapshot,
//     ) {
//       final levels = querySnapshot.docs.map((doc) {
//         final data = doc.data();
//         return LevelModel(id: doc.id, name: data['name']);
//       }).toList();
//       return Right(levels);
//     });
//   } on FirebaseException catch (e) {
//     return Left(firebaseFirestoreErrorHandler.mapFirebaseFirestoreException(e));
//   }
// }
