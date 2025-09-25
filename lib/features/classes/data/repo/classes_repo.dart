import 'package:dartz/dartz.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';

abstract class ClassesRepo {
  Future<Either<String, void>> addClass(ClassModel classModel);
  Future<Either<String, void>> deleteClass({required ClassModel classModel});
  Stream<List<ClassModel>> getClasses({required String levelId});
  Future<Either<String, void>> updateClass(ClassModel classModel);
}
