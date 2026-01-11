import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:david_psalmist/features/class_view/data/repo/scanner_repo.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepo _scannerRepo;
  final StudentRepo _studentRepo;

  // Batch mode: List to hold scanned students
  List<StudentModel> scannedStudents = [];
  // Track students who already have attendance recorded (newly added students)
  Set<String> studentsWithAttendance = {};

  ScannerCubit(this._scannerRepo, this._studentRepo) : super(ScannerInitial());

  Future<void> scanQRCode(MobileScannerController controller) async {
    emit(ScannerLoading());
    final result = await _scannerRepo.scanQRCode(controller);
    result.fold(
      (error) => emit(ScannerError(error)),
      (scannedName) => emit(ScannerSuccess(scannedName)),
    );
  }

  /// Process a scanned code string coming from the UI's onDetect callback.
  ///
  /// This avoids creating a race between the UI's onDetect and repo-based
  /// controller subscriptions. If you later need to validate or lookup the
  /// scanned code (e.g. map to a user name), call repo methods here.
  void processScannedCode(String code) {
    if (code.isEmpty) return;
    emit(ScannerLoading());
    // For now we treat the scanned code as the scannedName. If additional
    // processing is required (e.g. repo lookup), do it here and emit
    // ScannerSuccess or ScannerError accordingly.
    emit(ScannerSuccess(code));
  }

  Future<void> checkStudentAttendance({
    required String studentName,
    required String levelName,
    required ClassModel classModel,
  }) async {
    emit(ScannerProcessingAttendance());
    final result = await _studentRepo.addStudentByQRCode(
      studentName: studentName,
      levelName: levelName,
      classModel: classModel,
    );
    result.fold(
      (error) => emit(ScannerAttendanceError(error)),
      (message) => emit(ScannerAttendanceChecked(message: message)),
    );
  }

  Future<void> addStudentByQRCode({
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
    emit(ScannerLoading());
    final result = await _studentRepo.addStudentByQRCode(
      classModel: classModel,
      studentName: studentName,
      levelName: levelName,
      sex: sex,
      phoneNumber: phoneNumber,
      parentNumber: parentNumber,
      address: address,
      birthday: birthday,
      fatherName: fatherName,
      isPsalmist: isPsalmist,
    );
    result.fold(
      (error) => emit(ScannerError(error)),
      (message) => emit(ScannerSuccess(message)),
    );
  }

  Future<void> updateStudent({required StudentModel studentModel}) async {
    emit(ScannerLoading());
    final result = await _studentRepo.updateStudent(studentModel: studentModel);
    result.fold(
      (error) => emit(ScannerError(error)),
      (message) => emit(ScannerSuccess(message)),
    );
  }

  // Batch Attendance Methods
  void enableBatchMode() {
    scannedStudents.clear();
    studentsWithAttendance.clear();
    emit(ScannerBatchMode([]));
  }

  Future<void> addStudentToBatchFromName({
    required String studentName,
    required String levelName,
    required ClassModel classModel,
  }) async {
    try {
      final existingStudentsEither = await _studentRepo.getStudentsByClassId(
        classModel,
      );

      final List<StudentModel> existingStudents = existingStudentsEither.fold(
        (error) => [],
        (students) => students,
      );

      StudentModel? foundStudent;
      for (var student in existingStudents) {
        String fullName =
            '${student.firstName!.toLowerCase()} ${student.lastName!.toLowerCase()}';
        if (fullName == studentName.toLowerCase()) {
          foundStudent = student;
          break;
        }
      }

      if (foundStudent != null) {
        // Student exists - add to batch
        bool alreadyScanned = scannedStudents.any(
          (s) => s.studentId == foundStudent!.studentId,
        );

        if (!alreadyScanned) {
          scannedStudents.add(foundStudent);
          emit(ScannerBatchMode(List.from(scannedStudents)));
        } else {
          emit(ScannerBatchError('student_already_scanned'.tr()));
          Future.delayed(const Duration(milliseconds: 500), () {
            emit(ScannerBatchMode(List.from(scannedStudents)));
          });
        }
      } else {
        // Student doesn't exist - add them using addStudentByQRCode
        final addResult = await _studentRepo.addStudentByQRCode(
          classModel: classModel,
          studentName: studentName,
          levelName: levelName,
        );

        addResult.fold(
          (error) {
            emit(ScannerBatchError(error));
            Future.delayed(const Duration(milliseconds: 500), () {
              emit(ScannerBatchMode(List.from(scannedStudents)));
            });
          },
          (successMessage) async {
            // Fetch the newly added student
            final updatedStudentsEither = await _studentRepo
                .getStudentsByClassId(classModel);

            updatedStudentsEither.fold(
              (error) {
                emit(ScannerBatchError(error));
                Future.delayed(const Duration(milliseconds: 500), () {
                  emit(ScannerBatchMode(List.from(scannedStudents)));
                });
              },
              (students) {
                // Find the newly added student
                StudentModel? newStudent;
                for (var student in students) {
                  String fullName =
                      '${student.firstName!.toLowerCase()} ${student.lastName!.toLowerCase()}';
                  if (fullName == studentName.toLowerCase()) {
                    newStudent = student;
                    break;
                  }
                }

                if (newStudent != null) {
                  scannedStudents.add(newStudent);
                  // Mark this student as already having attendance recorded
                  studentsWithAttendance.add(newStudent.studentId!);
                  emit(ScannerBatchMode(List.from(scannedStudents)));
                }
              },
            );
          },
        );
      }
    } catch (e) {
      emit(ScannerBatchError('error_occurred'.tr()));
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(ScannerBatchMode(List.from(scannedStudents)));
      });
    }
  }

  void removeStudentFromBatch(String studentId) {
    scannedStudents.removeWhere((s) => s.studentId == studentId);
    studentsWithAttendance.remove(studentId);
    emit(ScannerBatchMode(List.from(scannedStudents)));
  }

  Future<void> submitBatchAttendance() async {
    if (scannedStudents.isEmpty) {
      emit(ScannerBatchError('No students to submit'));
      return;
    }

    emit(ScannerBatchSubmitting());

    try {
      // Filter out students who already have attendance recorded
      final studentsNeedingAttendance = scannedStudents
          .where(
            (student) => !studentsWithAttendance.contains(student.studentId),
          )
          .toList();

      if (studentsNeedingAttendance.isEmpty) {
        // All students already have attendance
        scannedStudents.clear();
        studentsWithAttendance.clear();
        emit(
          ScannerBatchSuccess(
            'Batch attendance recorded for ${scannedStudents.length} students',
          ),
        );
        return;
      }

      final result = await _studentRepo.batchStudentAttendance(
        students: studentsNeedingAttendance,
      );

      result.fold((error) => emit(ScannerBatchError(error)), (message) {
        scannedStudents.clear();
        studentsWithAttendance.clear();
        emit(ScannerBatchSuccess(message));
      });
    } catch (e) {
      emit(ScannerBatchError('Error submitting batch: $e'));
    }
  }

  void clearBatch() {
    scannedStudents.clear();
    studentsWithAttendance.clear();
    emit(ScannerBatchMode([]));
  }
}
