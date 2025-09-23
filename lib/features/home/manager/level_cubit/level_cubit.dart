import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:david_psalmist/features/home/data/repo/level_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit(this._levelRepo) : super(LevelInitial());
  final LevelRepo _levelRepo;

  Future<void> addLevel(String levelName) async {
    emit(LevelLoading());

    final levelModel = LevelModel(id: Uuid().v4(), name: levelName);
    final result = await _levelRepo.addLevel(levelModel);
    result.fold((l) => emit(LevelError(l)), (r) => emit(LevelLoaded()));
  }

  Future<void> deleteLevel({required String levelId}) async {
    emit(LevelLoading());
    final result = await _levelRepo.deleteLevel(levelId: levelId);
    result.fold((l) => emit(LevelError(l)), (r) => emit(LevelLoaded()));
  }
}
