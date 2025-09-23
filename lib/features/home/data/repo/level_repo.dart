import 'package:dartz/dartz.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';

abstract class LevelRepo {
  Future<Either<String, void>> addLevel(LevelModel levelModel);
  Future<Either<String, void>> deleteLevel({required String levelId});
}
