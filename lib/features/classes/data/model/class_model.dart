class ClassModel {
  final String id;
  final String name;
  final String levelId;

  ClassModel({required this.id, required this.name, required this.levelId});

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      levelId: map['levelId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'levelId': levelId};
  }
}
