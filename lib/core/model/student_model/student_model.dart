import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String? firstName;
  final String? lastName;
  final String? studentId;
  int? attendanceCount;
  final String? sex;
  final String? phomeNumber;
  final String? parentNumber;
  final String? address;
  final DateTime? birthday;
  final String? studentFather;
  final bool? isPsalmist;
  final DateTime? createdAt;
  final String? levelName;
  final String? levelId;
  final String? className;
  final String? classId;

  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.studentId,
    required this.attendanceCount,
    required this.sex,
    required this.phomeNumber,
    required this.parentNumber,
    required this.address,
    required this.birthday,
    required this.studentFather,
    required this.isPsalmist,
    required this.createdAt,
    required this.levelName,
    required this.levelId,
    required this.className,
    required this.classId,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      try {
        if (value is DateTime) return value;
        if (value is Timestamp) return value.toDate();
        if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
        if (value is String) return DateTime.tryParse(value);
      } catch (_) {}
      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return StudentModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      studentId: map['studentId'] as String?,
      attendanceCount: parseInt(map['attendanceCount']) ?? 0,
      sex: map['sex'] as String?,
      phomeNumber: map['phomeNumber'] as String?,
      parentNumber: map['parentNumber'] as String?,
      address: map['address'] as String?,
      birthday: parseDate(map['birthday']),
      studentFather: map['studentFather'] as String?,
      isPsalmist: map['isPsalmist'] as bool?,
      createdAt: parseDate(map['createdAt']),
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
      'studentId': studentId,
      'attendanceCount': attendanceCount,
      'sex': sex,
      'phomeNumber': phomeNumber,
      'parentNumber': parentNumber,
      'address': address,
      'birthday': birthday,
      'studentFather': studentFather,
      'isPsalmist': isPsalmist,
      'createdAt': createdAt,
      'levelName': levelName,
      'levelId': levelId,
      'className': className,
      'classId': classId,
    };
  }
}
