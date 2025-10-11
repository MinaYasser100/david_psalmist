import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';

class AttendanceServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getAttendanceSnapshot(
    StudentModel studentModel,
  ) {
    return _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .collection(ConstantVariable.attendanceCollection)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
