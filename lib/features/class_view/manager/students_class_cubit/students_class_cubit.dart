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
}
