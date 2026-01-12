import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_bottom_sheet.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/class_body_view.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/normal_mode_app_bar.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanner_options_bottom_sheet.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/selection_mode_app_bar.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
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
    return BlocBuilder<StudentsClassCubit, StudentsClassState>(
      builder: (context, state) {
        final cubit = context.read<StudentsClassCubit>();
        final isSelectionMode = state is StudentsClassSelectionMode;
        final selectedCount = switch (state) {
          StudentsClassSelectionMode s => s.selectedStudentIds.length,
          _ => 0,
        };

        return Scaffold(
          appBar: isSelectionMode
              ? SelectionModeAppBar(
                  selectedCount: selectedCount,
                  totalStudents: cubit.students.length,
                  onClose: () => cubit.disableSelectionMode(),
                  onSelectAll: () => cubit.selectAllStudents(),
                  onDeselectAll: () => cubit.deselectAllStudents(),
                  onSubmit: () => cubit.submitSelectedStudentsAttendance(),
                )
              : NormalModeAppBar(
                  title: widget.classModel.name,
                  onSearch: () => _navigateToSearch(context, cubit),
                  onAdd: () => _showAddStudentBottomSheet(context),
                  onEnableSelection: () => cubit.enableSelectionMode(),
                ),
          body: ClassBodyView(classModel: widget.classModel),
          floatingActionButton: isSelectionMode
              ? null
              : FloatingActionButton(
                  onPressed: () => _showScannerOptions(context),
                  child: const Icon(Icons.qr_code_scanner),
                ),
        );
      },
    );
  }

  void _navigateToSearch(BuildContext context, StudentsClassCubit cubit) {
    context.push(
      Routes.studentsSearchView,
      extra: {
        'students': cubit.students,
        'classModel': widget.classModel,
      },
    );
  }

  void _showScannerOptions(BuildContext context) {
    ScannerOptionsBottomSheet.show(
      context,
      onSingleScan: () => _showQRScanner(context, batchMode: false),
      onBatchScan: () => _showQRScanner(context, batchMode: true),
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

