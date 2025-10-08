import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';

class StudentsClassServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getStudentsSnapShot(
    ClassModel classModel,
  ) {
    return _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(classModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(classModel.id)
        .collection(ConstantVariable.studentsCollection)
        .snapshots();
  }
}
