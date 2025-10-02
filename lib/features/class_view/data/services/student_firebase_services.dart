import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> addStudentToClass({
    required StudentModel studentModel,
    required ClassModel classModel,
  }) async {
    await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(classModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(classModel.id)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .set(studentModel.toMap());
  }

  Future<void> updateStudentAttendance({
    required StudentModel studentModel,
  }) async {
    await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .update(studentModel.toMap());
  }

  Future<void> attendanceRecorded({required StudentModel studentModel}) async {
    AttendanceModel attendanceModel = AttendanceModel(
      id: Uuid().v4(),
      studentId: studentModel.studentId!,
      date: DateTime.now(),
    );
    await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .collection(ConstantVariable.attendanceCollection)
        .doc(attendanceModel.id)
        .set(attendanceModel.toMap());
  }
}
