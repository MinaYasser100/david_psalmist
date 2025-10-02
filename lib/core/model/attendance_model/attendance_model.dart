import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String studentId;
  final DateTime date;

  AttendanceModel({
    required this.id,
    required this.studentId,
    required this.date,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as String,
      studentId: map['studentId'] as String,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'studentId': studentId, 'date': date};
  }
}
