import 'package:david_psalmist/features/class_view/manager/cubit/students_class_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassBodyView extends StatelessWidget {
  const ClassBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsClassCubit, StudentsClassState>(
      builder: (context, state) {
        if (state is StudentsClassLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StudentsClassLoaded) {
          final students = state.students;

          if (students.isEmpty) {
            return const Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text('${student.firstName!} ${student.lastName!}'),
                subtitle: Text('ID: ${student.studentId!}'),
              );
            },
          );
        } else if (state is StudentsClassError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
