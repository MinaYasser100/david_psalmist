class ClassModel {
  final String id;
  final String name;
  final String levelId;
  final String? levelName;

  ClassModel({
    required this.id,
    required this.name,
    required this.levelId,
    this.levelName,
  });

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      levelId: map['levelId'] ?? '',
      levelName: map['levelName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'levelId': levelId,
      if (levelName != null) 'levelName': levelName,
    };
  }
}
