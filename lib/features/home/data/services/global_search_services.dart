import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';

class GlobalSearchServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Search all students across all levels and classes
  Future<List<StudentModel>> searchAllStudents(String query) async {
    if (query.trim().isEmpty) return [];

    final queryLower = query.toLowerCase();

    // Use collectionGroup to search across all 'students' sub-collections
    final querySnapshot = await _firestore
        .collectionGroup(ConstantVariable.studentsCollection)
        .get();

    // Filter locally by name (since Firestore doesn't support case-insensitive search)
    final List<StudentModel> matchedStudents = [];

    for (var doc in querySnapshot.docs) {
      try {
        final student = StudentModel.fromMap(doc.data());
        final firstName = student.firstName?.toLowerCase() ?? '';
        final lastName = student.lastName?.toLowerCase() ?? '';

        if (firstName.contains(queryLower) || lastName.contains(queryLower)) {
          matchedStudents.add(student);
        }
      } catch (e) {
        // Skip invalid student documents
        continue;
      }
    }

    return matchedStudents;
  }
}
