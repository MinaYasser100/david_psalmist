import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/firebase/firebase_firestore_error_handler.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/attendance/data/service/attendance_services.dart';

abstract class AttendanceRepo {
  Stream<Either<String, List<AttendanceModel>>> getAttendanceStream(
    StudentModel studentModel,
  );
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
    } catch (e) {
      return Stream.value(Left(e.toString()));
    }
  }
}
