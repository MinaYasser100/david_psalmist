import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/class_view/data/services/student_firebase_services.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:uuid/uuid.dart';

abstract class StudentRepo {
  Future<Either<String, String>> addStudentByQRCode({
    required ClassModel classModel,
    required String studentName,
    required String levelName,
    String? sex,
    String? phoneNumber,
    String? parentNumber,
    String? address,
    DateTime? birthday,
    String? fatherName,
    bool? isPsalmist,
  });
  Future<Either<String, List<StudentModel>>> getStudentsByClassId(
    ClassModel classModel,
  );

  Future<Either<String, String>> studentAttendance({
    required StudentModel studentModel,
  });
}

class StudentRepoImpl implements StudentRepo {
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;
  final StudentFirebaseServices studentFirebaseServices;

  StudentRepoImpl({
    required this.firestoreErrorHandler,
    required this.studentFirebaseServices,
  });
  @override
  Future<Either<String, String>> addStudentByQRCode({
    required ClassModel classModel,
    required String studentName,
    required String levelName,
    String? sex,
    String? phoneNumber,
    String? parentNumber,
    String? address,
    DateTime? birthday,
    String? fatherName,
    bool? isPsalmist,
  }) async {
    try {
      final existingStudentsEither = await getStudentsByClassId(classModel);

      final List<StudentModel> existingStudents = existingStudentsEither.fold(
        (error) => throw Exception(error),
        (students) => students,
      );
      log(existingStudents.length.toString());
      log(existingStudents.length.toString());

      for (var element in existingStudents) {
        String name =
            '${element.firstName!.toLowerCase()} ${element.lastName!.toLowerCase()}';
        if (name == studentName.toLowerCase()) {
          final attendanceResult = await studentAttendance(
            studentModel: element,
          );
          return attendanceResult.fold(
            (l) => Left(l),
            (r) =>
                Right('Successfully recorded attendance for existing student'),
          );
        }
      }

      StudentModel studentModel = StudentModel(
        firstName: studentName.split(' ').first,
        lastName: studentName.split(' ').length > 1
            ? studentName.split(' ').sublist(1).join(' ')
            : '',
        studentId: Uuid().v4(),
        attendanceCount: 0,
        sex: sex,
        phomeNumber: phoneNumber,
        parentNumber: parentNumber,
        address: address,
        birthday: birthday,
        studentFather: fatherName,
        isPsalmist: isPsalmist ?? false,
        createdAt: DateTime.now(),
        levelName: levelName,
        levelId: classModel.levelId,
        className: classModel.name,
        classId: classModel.id,
      );
      await studentFirebaseServices.addStudentToClass(
        studentModel: studentModel,
        classModel: classModel,
      );
      // After adding, record attendance for the new student
      final attendanceResult = await studentAttendance(
        studentModel: studentModel,
      );
      return attendanceResult.fold(
        (l) => Left(l),
        (r) => Right('Student added and attendance recorded'),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to add student');
    } catch (e) {
      return const Left('Failed to add student');
    }
  }

  @override
  Future<Either<String, List<StudentModel>>> getStudentsByClassId(
    ClassModel classModel,
  ) async {
    try {
      log(
        'Fetching students for class ${classModel.name} (${classModel.id}) in level ${classModel.levelId}',
      );
      var result = await studentFirebaseServices.getStudentsByClassId(
        classModel,
      );

      final List<StudentModel> students = [];
      for (final doc in result.docs) {
        try {
          students.add(StudentModel.fromMap(doc.data()));
        } catch (e, st) {
          log('Failed to parse student doc ${doc.id}: $e\n$st');
          // skip bad doc
        }
      }

      log('Fetched ${students.length} students for class ${classModel.name}');
      return Right(students);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to fetch students');
    } catch (e, st) {
      log('getStudentsByClassId unexpected error: $e\n$st');
      return const Left('Failed to fetch students');
    }
  }

  @override
  Future<Either<String, String>> studentAttendance({
    required StudentModel studentModel,
  }) async {
    try {
      studentModel.attendanceCount = studentModel.attendanceCount! + 1;
      await studentFirebaseServices.updateStudentAttendance(
        studentModel: studentModel,
      );
      await studentFirebaseServices.attendanceRecorded(
        studentModel: studentModel,
      );
      return Right('Attendance recorded successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to record attendance');
    } catch (e) {
      return const Left('Failed to record attendance');
    }
  }
}
