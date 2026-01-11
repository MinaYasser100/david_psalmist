import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_bottom_sheet.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/class_body_view.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:david_psalmist/features/class_view/ui/scanner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          customActionBar(
            onPressed: () {
              context.push(
                Routes.studentsSearchView,
                extra: {
                  'students': context.read<StudentsClassCubit>().students,
                  'classModel': widget.classModel,
                },
              );
            },
            icon: Icons.search,
          ),
          customActionBar(
            onPressed: () => _showAddStudentBottomSheet(context),
            icon: Icons.add,
          ),
        ],
      ),
      body: ClassBodyView(classModel: widget.classModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showScannerOptions(context),
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _showScannerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.qr_code_scanner,
                color: ColorsTheme().primaryColor,
              ),
              title: Text('Single Scan'.tr()),
              subtitle: Text('Record one student at a time'.tr()),
              onTap: () {
                Navigator.pop(context);
                _showQRScanner(context, batchMode: false);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.qr_code_2, color: ColorsTheme().primaryColor),
              title: Text('Batch Scan'.tr()),
              subtitle: Text('Scan multiple students and submit together'.tr()),
              onTap: () {
                Navigator.pop(context);
                _showQRScanner(context, batchMode: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  IconButton customActionBar({
    required void Function() onPressed,
    required IconData icon,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsTheme().whiteColor,
        ),
        child: Icon(icon, color: ColorsTheme().primaryDark),
      ),
    );
  }

  void _showQRScanner(BuildContext context, {bool batchMode = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ScannerCubit>(),
          child: ScannerPage(
            classModel: widget.classModel,
            levelName: '',
            batchMode: batchMode,
          ),
        ),
      ),
    );
  }

  void _showAddStudentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ScannerCubit>(),
        child: AddStudentBottomSheet(
          classModel: widget.classModel,
          levelName: widget.classModel.levelName ?? 'Unknown Level',
        ),
      ),
    );
  }
}
