import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/attendance/data/service/attendance_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:uuid/uuid.dart';

abstract class AttendanceRepo {
  Stream<Either<String, List<AttendanceModel>>> getAttendanceStream(
    StudentModel studentModel,
  );

  Future<Either<String, String>> deleteAttendanceRecord({
    required StudentModel studentModel,
    required AttendanceModel attendanceModel,
  });

  Future<Either<String, String>> addAttendanceRecord({
    required StudentModel studentModel,
    required DateTime selectedDate,
  });

  Future<Either<String, String>> updateAttendanceLessons({
    required StudentModel studentModel,
    required AttendanceModel attendanceModel,
  });
}

class AttendanceRepoImpl implements AttendanceRepo {
  final AttendanceServices attendanceServices;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;

  AttendanceRepoImpl({
    required this.attendanceServices,
    required this.firestoreErrorHandler,
  });
  @override
  Stream<Either<String, List<AttendanceModel>>> getAttendanceStream(
    StudentModel studentModel,
  ) {
    try {
      return attendanceServices.getAttendanceSnapshot(studentModel).map((
        snapshot,
      ) {
        if (snapshot.docs.isEmpty) {
          return const Right(
            [],
          ); // Return an empty list if no attendance records
        }

        final List<AttendanceModel> attendanceRecords = snapshot.docs.map((
          doc,
        ) {
          final data = doc.data();
          return AttendanceModel.fromMap(data);
        }).toList();

        return Right(attendanceRecords);
      });
    } on FirebaseException catch (e) {
      return Stream.value(
        Left(firestoreErrorHandler.mapFirebaseFirestoreException(e)),
      );
    } catch (e) {
      return Stream.value(Left(e.toString()));
    }
  }

  @override
  Future<Either<String, String>> deleteAttendanceRecord({
    required StudentModel studentModel,
    required AttendanceModel attendanceModel,
  }) async {
    try {
      await attendanceServices.deleteAttendanceRecord(
        studentModel: studentModel,
        attendanceModel: attendanceModel,
      );
      return Right('Attendance record deleted successfully'.tr());
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      return Left('Unknown error occurred while deleting attendance'.tr());
    }
  }

  @override
  Future<Either<String, String>> addAttendanceRecord({
    required StudentModel studentModel,
    required DateTime selectedDate,
  }) async {
    try {
      final attendanceModel = AttendanceModel(
        id: Uuid().v4(),
        studentId: studentModel.studentId!,
        date: selectedDate,
        lessonsAttended: 3, // Default 3 lessons
      );
      await attendanceServices.addAttendanceRecord(
        studentModel: studentModel,
        attendanceModel: attendanceModel,
      );
      return Right('Attendance recorded successfully'.tr());
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      return Left('Failed to record attendance'.tr());
    }
  }

  @override
  Future<Either<String, String>> updateAttendanceLessons({
    required StudentModel studentModel,
    required AttendanceModel attendanceModel,
  }) async {
    try {
      await attendanceServices.updateAttendanceLessons(
        studentModel: studentModel,
        attendanceModel: attendanceModel,
      );
      return Right('Lessons updated successfully'.tr());
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      return Left('Failed to update lessons'.tr());
    }
  }
}
