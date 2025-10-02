import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/class_view/data/services/student_firebase_services.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:uuid/uuid.dart';

abstract class StudentRepo {
  Future<Either<String, String>> addStudentByQRCode({
    required ClassModel classModel,
    required String studentName,
    required String levelName,
  });
  Future<Either<String, List<StudentModel>>> getStudentsByClassId(
    ClassModel classModel,
  );
}

class StudentRepoImpl implements StudentRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  }) async {
    try {
      final existingStudentsEither = await getStudentsByClassId(classModel);

      final List<StudentModel> existingStudents = existingStudentsEither.fold(
        (error) => [],
        (students) => students,
      );

      for (var element in existingStudents) {
        String name =
            '${element.firstName!.toLowerCase()} ${element.lastName!.toLowerCase()}';
        if (name.toLowerCase() == studentName.toLowerCase()) {
          return Left('Student already exists in this class');
        }
      }

      StudentModel studentModel = StudentModel(
        firstName: studentName.split(' ').first,
        lastName: studentName.split(' ').length > 1
            ? studentName.split(' ').sublist(1).join(' ')
            : '',
        studentId: Uuid().v4(),
        attendanceCount: 0,
        sex: null,
        phomeNumber: null,
        parentNumber: null,
        address: null,
        birthday: null,
        studentFather: null,
        isPsalmist: false,
        createdAt: DateTime.now(),
        levelName: levelName,
        levelId: classModel.levelId,
        className: classModel.name,
        classId: classModel.id,
      );
      await _firestore
          .collection(ConstantVariable.levelsCollection)
          .doc(classModel.levelId)
          .collection(ConstantVariable.classesCollection)
          .doc(classModel.id)
          .collection(ConstantVariable.studentsCollection)
          .doc(Uuid().v4())
          .set(studentModel.toMap());
      return Right('Student added successfully');
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
      var result = await studentFirebaseServices.getStudentsByClassId(
        classModel,
      );
      return Right(
        result.docs.map((e) => StudentModel.fromMap(e.data())).toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to fetch students');
    } catch (e) {
      return const Left('Failed to fetch students');
    }
  }
}
