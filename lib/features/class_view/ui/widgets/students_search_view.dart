import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StudentsSearchView extends StatefulWidget {
  const StudentsSearchView({super.key, required this.students});
  final List<StudentModel> students;

  @override
  State<StudentsSearchView> createState() => _StudentsSearchViewState();
}

class _StudentsSearchViewState extends State<StudentsSearchView> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late List<StudentModel> _filteredStudents;
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
      appBar: AppBar(title: Text('Search here...'.tr())),
      body: Hero(
        tag: 'search',
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
              sliver: SliverToBoxAdapter(
                child: CustomTextFormField(
                  textFieldModel: TextFieldModel(
                    hintText: "Search by name".tr(),
                    labelText: "Search".tr(),
                    controller: _searchController,
                    autofocus: true,
                    focusNode: _searchFocusNode,
                    keyboardType: TextInputType.text,
                    icon: Icons.search,
                    validator: (value) => null,
                    onChanged: (value) {
                      _filterStudents(value);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            if (widget.students.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "No students in this class yet, add new students to get started!"
                        .tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorsTheme().primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            else if (_filteredStudents.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "No students found".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorsTheme().primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final student = _filteredStudents[index];
                  return FadeInRight(
                    child: CustomStudentItem(student: student, index: index),
                  );
                }, childCount: _filteredStudents.length),
              ),
          ],
        ),
      ),
    );
  }

  void _filterStudents(String query) {
    final queryLower = query.toLowerCase().trim();
    List<StudentModel> filteredStudents;
    if (queryLower.isEmpty) {
      filteredStudents = List<StudentModel>.from(widget.students);
    } else {
      filteredStudents = widget.students.where((student) {
        final nameLower = (student.firstName ?? '').toLowerCase();
        final lastNameLower = (student.lastName ?? '').toLowerCase();
        return nameLower.contains(queryLower) ||
            lastNameLower.contains(queryLower);
      }).toList();
    }

    setState(() {
      _filteredStudents = filteredStudents;
    });
  }
}
