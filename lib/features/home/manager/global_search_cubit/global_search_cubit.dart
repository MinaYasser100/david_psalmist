import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/home/data/repo/global_search_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_search_state.dart';

class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  GlobalSearchCubit(this._searchRepo) : super(GlobalSearchInitial());

  final GlobalSearchRepo _searchRepo;
  List<StudentModel> allSearchResults = [];
  List<StudentModel> filteredResults = [];

  Future<void> searchStudents(String query) async {
    if (query.trim().isEmpty) {
      emit(GlobalSearchInitial());
      return;
    }

    emit(GlobalSearchLoading());

    final result = await _searchRepo.searchStudents(query);

    result.fold((error) => emit(GlobalSearchError(error)), (students) {
      allSearchResults = students;
      filteredResults = students;
      emit(GlobalSearchLoaded(students));
    });
  }

  void clearSearch() {
    allSearchResults.clear();
    filteredResults.clear();
    emit(GlobalSearchInitial());
  }
}
