import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/class_body_view.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';

import 'package:david_psalmist/features/class_view/ui/scanner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassView extends StatefulWidget {
  const ClassView({super.key, required this.classModel});
  final ClassModel classModel;

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  @override
  void initState() {
    context.read<StudentsClassCubit>().getStudents(widget.classModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classModel.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorsTheme().whiteColor,
              ),
              child: Icon(Icons.add, color: ColorsTheme().primaryDark),
            ),
          ),
        ],
      ),
      body: const ClassBodyView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQRScanner(context),
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _showQRScanner(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            ScannerPage(classModel: widget.classModel, levelName: ''),
      ),
    );
  }
}
