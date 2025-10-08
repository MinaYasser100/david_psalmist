import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/class_view/data/services/students_class_services.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class StudentsClassRepo {
  Stream<Either<String, List<StudentModel>>> getStudentsWithAttendance(
    ClassModel classModel,
  );
}

class StudentsClassRepoImpl implements StudentsClassRepo {
  final StudentsClassServices studentsClassServices;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;
  StudentsClassRepoImpl({
    required this.studentsClassServices,
    required this.firestoreErrorHandler,
  });
  @override
  Stream<Either<String, List<StudentModel>>> getStudentsWithAttendance(
    ClassModel classModel,
  ) {
    try {
      return studentsClassServices.getStudentsSnapShot(classModel).map((
        snapshot,
      ) {
        if (snapshot.docs.isEmpty) {
          return const Right([]); // قايمة فارغة لو مفيش طلاب
        }

        final List<StudentModel> students = [];
        for (final doc in snapshot.docs) {
          try {
            final studentData = doc.data();
            final student = StudentModel.fromMap(studentData);
            students.add(student);
          } catch (e, st) {
            log('Error parsing student data: $e');
            log(st.toString());
            continue;
          }
        }

        return Right(students);
      });
    } on FirebaseException catch (e) {
      return Stream.value(Left(firestoreErrorHandler.mapStreamError(e)));
    } catch (e) {
      // خطأ أولي في تهيئة الـ Stream
      return Stream.value(Left('Initial error: $e'));
    }
  }
}
