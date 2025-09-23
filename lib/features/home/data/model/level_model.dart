// level_model.dart
import 'package:hive_flutter/hive_flutter.dart';

part 'level_model.g.dart';

@HiveType(typeId: 1)
class LevelModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  LevelModel({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory LevelModel.fromMap(Map<String, dynamic> map) {
    return LevelModel(id: map['id'] as String, name: map['name'] as String);
  }
}
