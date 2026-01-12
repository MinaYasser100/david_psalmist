import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/class_view/data/repo/student_repo.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/search_input_section.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/search_normal_app_bar.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/search_selection_app_bar.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/search_student_list_item.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsSearchView extends StatefulWidget {
  const StudentsSearchView({
    super.key,
    required this.students,
    required this.classModel,
  });
  final List<StudentModel> students;
  final ClassModel classModel;

  @override
  State<StudentsSearchView> createState() => _StudentsSearchViewState();
}

class _StudentsSearchViewState extends State<StudentsSearchView> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late List<StudentModel> _filteredStudents;
  bool _isSelectionMode = false;
  final Set<String> _selectedStudentIds = {};
  bool _isSubmitting = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _filteredStudents = List<StudentModel>.from(widget.students);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSelectionMode
          ? SearchSelectionAppBar(
              selectedCount: _selectedStudentIds.length,
              totalCount: _filteredStudents.length,
              isSubmitting: _isSubmitting,
              onClose: _disableSelectionMode,
              onToggleSelectAll: _toggleSelectAll,
              onSubmit: _submitAttendance,
            )
          : SearchNormalAppBar(onEnableSelection: _enableSelectionMode),
      body: Hero(
        tag: 'search',
        child: CustomScrollView(
          slivers: [
            SearchInputSection(
              searchController: _searchController,
              searchFocusNode: _searchFocusNode,
              onSearchChanged: (value) {
                _filterStudents(value);
                setState(() {});
              },
            ),
            if (widget.students.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No students found'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else if (_filteredStudents.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No results found'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final student = _filteredStudents[index];
                  final isSelected = _selectedStudentIds.contains(
                    student.studentId,
                  );

                  return SearchStudentListItem(
                    student: student,
                    index: index,
                    classModel: widget.classModel,
                    isSelectionMode: _isSelectionMode,
                    isSelected: isSelected,
                    onTap: () => _toggleStudentSelection(student.studentId!),
                  );
                }, childCount: _filteredStudents.length),
              ),
          ],
        ),
      ),
    );
  }

  void _enableSelectionMode() {
    setState(() {
      _isSelectionMode = true;
    });
  }

  void _disableSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedStudentIds.clear();
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedStudentIds.length == _filteredStudents.length) {
        _selectedStudentIds.clear();
      } else {
        _selectedStudentIds.addAll(
          _filteredStudents.map((s) => s.studentId!).toList(),
        );
      }
    });
  }

  void _toggleStudentSelection(String studentId) {
    setState(() {
      if (_selectedStudentIds.contains(studentId)) {
        _selectedStudentIds.remove(studentId);
      } else {
        _selectedStudentIds.add(studentId);
      }
    });
  }

  void _filterStudents(String query) {
    setState(() {
      final filteredStudents = widget.students.where((student) {
        final firstName = student.firstName?.toLowerCase() ?? '';
        final lastName = student.lastName?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return firstName.contains(searchQuery) ||
            lastName.contains(searchQuery);
      }).toList();
      _filteredStudents = filteredStudents;
    });
  }

  Future<void> _submitAttendance() async {
    if (_selectedStudentIds.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final selectedStudents = _filteredStudents
          .where((s) => _selectedStudentIds.contains(s.studentId))
          .toList();

      final studentRepo = context.read<StudentRepo>();
      final result = await studentRepo.batchStudentAttendance(
        students: selectedStudents,
      );

      result.fold(
        (error) {
          if (mounted) {
            showErrorToast(context, 'Error'.tr(), error);
          }
        },
        (message) {
          if (mounted) {
            showSuccessToast(context, 'Success'.tr(), message);
            setState(() {
              _isSelectionMode = false;
              _selectedStudentIds.clear();
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        showErrorToast(context, 'Error'.tr(), e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
