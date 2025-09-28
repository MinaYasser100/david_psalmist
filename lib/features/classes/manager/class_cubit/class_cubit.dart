import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:david_psalmist/features/classes/data/repo/classes_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'class_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit(this._classesRepo) : super(ClassInitial());
  final ClassesRepo _classesRepo;

  Future<void> addClass({required ClassModel classModel}) async {
    emit(ClassLoading());
    final result = await _classesRepo.addClass(classModel);
    result.fold(
      (failure) => emit(ClassError(failure)),
      (_) => emit(ClassAdded()),
    );
  }

  Future<void> deleteClass({required ClassModel classModel}) async {
    emit(ClassLoading());
    final result = await _classesRepo.deleteClass(classModel: classModel);
    result.fold(
      (failure) => emit(ClassError(failure)),
      (_) => emit(ClassDeleted()),
    );
  }

  Future<void> updateClass({required ClassModel classModel}) async {
    emit(ClassLoading());
    final result = await _classesRepo.updateClass(classModel);
    result.fold(
      (failure) => emit(ClassError(failure)),
      (_) => emit(ClassUpdated()),
    );
  }

  Future<void> getClasses({required String levelId}) async {
    emit(ClassLoading());
    _classesRepo
        .getClasses(levelId: levelId)
        .listen(
          (classes) {
            emit(GetAllClassesSuccess(classes: classes));
          },
          onError: (error) {
            emit(ClassError(error.toString()));
          },
        );
  }
}
