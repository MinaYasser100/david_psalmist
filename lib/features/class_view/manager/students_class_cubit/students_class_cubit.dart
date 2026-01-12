import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:david_psalmist/features/class_view/data/repo/students_class_repo.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'students_class_state.dart';

class StudentsClassCubit extends Cubit<StudentsClassState> {
  StudentsClassCubit(this._studentsClassRepo, this._studentRepo)
    : super(StudentsClassInitial());

  final StudentsClassRepo _studentsClassRepo;
  final StudentRepo _studentRepo;
  List<StudentModel> students = <StudentModel>[];

  // Selection mode
  bool isSelectionMode = false;
  Set<String> selectedStudentIds = <String>{};

  void getStudents(ClassModel classModel) {
    emit(StudentsClassLoading());
    try {
      final stream = _studentsClassRepo.getStudentsWithAttendance(classModel);
      stream.listen((either) {
        either.fold((failure) => emit(StudentsClassError(message: failure)), (
          students,
        ) {
          this.students = students;
          emit(StudentsClassLoaded(students: students));
        });
      });
    } catch (e) {
      emit(StudentsClassError(message: e.toString()));
    }
  }

  Future<void> deleteStudent(StudentModel studentModel) async {
    try {
      final result = await _studentRepo.deleteStudent(
        studentModel: studentModel,
      );
      result.fold((error) => emit(StudentsClassError(message: error)), (
        success,
      ) {
        students.removeWhere((s) => s.studentId == studentModel.studentId);
        emit(StudentsClassLoaded(students: students));
      });
    } catch (e) {
      emit(StudentsClassError(message: e.toString()));
    }
  }

  // Selection Mode Methods
  void enableSelectionMode() {
    isSelectionMode = true;
    selectedStudentIds.clear();
    emit(
      StudentsClassSelectionMode(students: students, selectedStudentIds: {}),
    );
  }

  void disableSelectionMode() {
    isSelectionMode = false;
    selectedStudentIds.clear();
    emit(StudentsClassLoaded(students: students));
  }

  void toggleStudentSelection(String studentId) {
    if (selectedStudentIds.contains(studentId)) {
      selectedStudentIds.remove(studentId);
    } else {
      selectedStudentIds.add(studentId);
    }
    emit(
      StudentsClassSelectionMode(
        students: students,
        selectedStudentIds: Set.from(selectedStudentIds),
      ),
    );
  }

  void selectAllStudents() {
    selectedStudentIds = students.map((s) => s.studentId!).toSet();
    emit(
      StudentsClassSelectionMode(
        students: students,
        selectedStudentIds: Set.from(selectedStudentIds),
      ),
    );
  }

  void deselectAllStudents() {
    selectedStudentIds.clear();
    emit(
      StudentsClassSelectionMode(students: students, selectedStudentIds: {}),
    );
  }

  Future<void> submitSelectedStudentsAttendance() async {
    if (selectedStudentIds.isEmpty) {
      emit(StudentsClassBatchAttendanceError(message: 'No students selected'));
      // Return to selection mode
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(
          StudentsClassSelectionMode(
            students: students,
            selectedStudentIds: Set.from(selectedStudentIds),
          ),
        );
      });
      return;
    }

    emit(StudentsClassBatchAttendanceSubmitting());

    try {
      // Get selected students
      final selectedStudents = students
          .where((student) => selectedStudentIds.contains(student.studentId))
          .toList();

      final result = await _studentRepo.batchStudentAttendance(
        students: selectedStudents,
      );

      result.fold(
        (error) {
          emit(StudentsClassBatchAttendanceError(message: error));
          // Return to selection mode after error
          Future.delayed(const Duration(seconds: 2), () {
            emit(
              StudentsClassSelectionMode(
                students: students,
                selectedStudentIds: Set.from(selectedStudentIds),
              ),
            );
          });
        },
        (message) {
          emit(StudentsClassBatchAttendanceSuccess(message: message));
          // Clear selection and return to normal mode
          selectedStudentIds.clear();
          isSelectionMode = false;
          Future.delayed(const Duration(seconds: 2), () {
            emit(StudentsClassLoaded(students: students));
          });
        },
      );
    } catch (e) {
      emit(StudentsClassBatchAttendanceError(message: e.toString()));
      // Return to selection mode after error
      Future.delayed(const Duration(seconds: 2), () {
        emit(
          StudentsClassSelectionMode(
            students: students,
            selectedStudentIds: Set.from(selectedStudentIds),
          ),
        );
      });
    }
  }
}
