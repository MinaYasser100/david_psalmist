import 'package:dartz/dartz.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/home/data/services/global_search_services.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class GlobalSearchRepo {
  Future<Either<String, List<StudentModel>>> searchStudents(String query);
}

class GlobalSearchRepoImpl implements GlobalSearchRepo {
  final GlobalSearchServices _searchServices;

  GlobalSearchRepoImpl(this._searchServices);

  @override
  Future<Either<String, List<StudentModel>>> searchStudents(
    String query,
  ) async {
    try {
      final students = await _searchServices.searchAllStudents(query);
      return Right(students);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to search students');
    } catch (e) {
      return Left('Failed to search students: ${e.toString()}');
    }
  }
}
