import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String studentId;
  final DateTime date;
  final int lessonsAttended; // Number of lessons attended (0-3)

  AttendanceModel({
    required this.id,
    required this.studentId,
    required this.date,
    this.lessonsAttended = 3, // Default is 3 lessons
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as String,
      studentId: map['studentId'] as String,
      date: (map['date'] as Timestamp).toDate(),
      lessonsAttended: map['lessonsAttended'] as int? ?? 3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'studentId': studentId,
      'date': Timestamp.fromDate(date),
      'lessonsAttended': lessonsAttended,
    };
  }

  AttendanceModel copyWith({
    String? id,
    String? studentId,
    DateTime? date,
    int? lessonsAttended,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      date: date ?? this.date,
      lessonsAttended: lessonsAttended ?? this.lessonsAttended,
    );
  }
}
