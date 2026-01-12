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

  Future<void> updateStudentData({required StudentModel studentModel}) async {
    await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .update(studentModel.toMap());
  }

  Future<void> deleteStudent({required StudentModel studentModel}) async {
    final studentDocRef = _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId);

    // First, delete all attendance records in the Attendances sub-collection
    final attendancesSnapshot = await studentDocRef
        .collection(ConstantVariable.attendanceCollection)
        .get();

    // Use batch to delete all attendance documents
    final batch = _firestore.batch();

    for (var doc in attendancesSnapshot.docs) {
      batch.delete(doc.reference);
    }

    // Delete the student document itself
    batch.delete(studentDocRef);

    // Commit the batch
    await batch.commit();
  }

  /// Check if student has attendance record for today
  Future<bool> hasAttendanceToday({
    required StudentModel studentModel,
    DateTime? checkDate,
  }) async {
    final targetDate = checkDate ?? DateTime.now();
    final startOfDay = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    final endOfDay = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      23,
      59,
      59,
      999,
    );

    final snapshot = await _firestore
        .collection(ConstantVariable.levelsCollection)
        .doc(studentModel.levelId)
        .collection(ConstantVariable.classesCollection)
        .doc(studentModel.classId)
        .collection(ConstantVariable.studentsCollection)
        .doc(studentModel.studentId)
        .collection(ConstantVariable.attendanceCollection)
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  /// Check attendance for multiple students for a specific date
  Future<List<StudentModel>> filterStudentsWithoutTodayAttendance({
    required List<StudentModel> students,
    DateTime? checkDate,
  }) async {
    final List<StudentModel> studentsNeedingAttendance = [];

    for (var student in students) {
      final hasAttendance = await hasAttendanceToday(
        studentModel: student,
        checkDate: checkDate,
      );
      if (!hasAttendance) {
        studentsNeedingAttendance.add(student);
      }
    }

    return studentsNeedingAttendance;
  }

  Future<void> attendanceRecorded({required StudentModel studentModel}) async {
    AttendanceModel attendanceModel = AttendanceModel(
      id: Uuid().v4(),
      studentId: studentModel.studentId!,
      date: DateTime.now(),
      lessonsAttended: 3,
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

  Future<void> batchStudentAttendance({
    required List<StudentModel> students,
  }) async {
    final batch = _firestore.batch();
    final now = DateTime.now();

    for (var student in students) {
      final attendanceId = Uuid().v4();
      final attendanceRef = _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(student.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(student.classId)
          .collection(ConstantVariable.studentsCollection)
          .doc(student.studentId)
          .collection(ConstantVariable.attendanceCollection)
          .doc(attendanceId);

      final attendanceData = AttendanceModel(
        id: attendanceId,
        studentId: student.studentId!,
        date: now,
        lessonsAttended: 3,
      ).toMap();

      batch.set(attendanceRef, attendanceData);

      final studentRef = _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(student.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(student.classId)
          .collection(ConstantVariable.studentsCollection)
          .doc(student.studentId);

      batch.update(studentRef, {'attendanceCount': FieldValue.increment(1)});
    }

    await batch.commit();
  }
}
