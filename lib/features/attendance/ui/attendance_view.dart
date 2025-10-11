import 'package:flutter/material.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance View')),
      body: const Center(child: Text('Attendance details will be shown here.')),
    );
  }
}
