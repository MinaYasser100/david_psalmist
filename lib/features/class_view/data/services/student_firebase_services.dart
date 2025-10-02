import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';

class StudentFirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> getStudentsByClassId(
    ClassModel classModel,
  ) async {
    return await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(classModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(classModel.id)
        .collection(ConstantVariable.studentsCollection)
        .get();
  }
}
