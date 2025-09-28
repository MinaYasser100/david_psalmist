class StudentModel {
  final String? firstName;
  final String? lastName;
  final String? sex;
  final String? phomeNumber;
  final String? parentNumber;
  final String? address;
  final DateTime? birthday;
  final String? studentFather;
  final bool? isPsalmist;
  final String? levelName;
  final String? levelId;
  final String? className;
  final String? classId;

  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.phomeNumber,
    required this.parentNumber,
    required this.address,
    required this.birthday,
    required this.studentFather,
    required this.isPsalmist,
    required this.levelName,
    required this.levelId,
    required this.className,
    required this.classId,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      sex: map['sex'] as String?,
      phomeNumber: map['phomeNumber'] as String?,
      parentNumber: map['parentNumber'] as String?,
      address: map['address'] as String?,
      birthday: map['birthday'] as DateTime?,
      studentFather: map['studentFather'] as String?,
      isPsalmist: map['isPsalmist'] as bool?,
      levelName: map['levelName'] as String?,
      levelId: map['levelId'] as String?,
      className: map['className'] as String?,
      classId: map['classId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'sex': sex,
      'phomeNumber': phomeNumber,
      'parentNumber': parentNumber,
      'address': address,
      'birthday': birthday,
      'studentFather': studentFather,
      'isPsalmist': isPsalmist,
      'levelName': levelName,
      'levelId': levelId,
      'className': className,
      'classId': classId,
    };
  }
}
