import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/features/home/manager/global_search_cubit/global_search_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/global_search_widgets/global_search_item.dart';
import 'package:david_psalmist/features/home/ui/widgets/global_search_widgets/global_search_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalSearchView extends StatefulWidget {
  const GlobalSearchView({super.key});

  @override
  State<GlobalSearchView> createState() => _GlobalSearchViewState();
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
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
      appBar: AppBar(title: Text('Search Students'.tr())),
      body: Column(
        children: [
          GlobalSearchInput(
            searchController: _searchController,
            searchFocusNode: _searchFocusNode,
            onSearchChanged: (query) {
              context.read<GlobalSearchCubit>().searchStudents(query);
            },
          ),
          Expanded(
            child: BlocBuilder<GlobalSearchCubit, GlobalSearchState>(
              builder: (context, state) {
                if (state is GlobalSearchInitial) {
                  return _buildInitialState();
                } else if (state is GlobalSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GlobalSearchError) {
                  return _buildErrorState(state.message);
                } else if (state is GlobalSearchLoaded) {
                  if (state.students.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildStudentsList(state.students);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Search for students'.tr(),
            style: AppTextStyles.styleMedium18sp(
              context,
            ).copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Type student name to search'.tr(),
            style: AppTextStyles.styleRegular14sp(
              context,
            ).copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No students found'.tr(),
            style: AppTextStyles.styleMedium18sp(
              context,
            ).copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Error'.tr(),
            style: AppTextStyles.styleMedium18sp(
              context,
            ).copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyles.styleRegular14sp(
              context,
            ).copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsList(List<StudentModel> students) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return GlobalSearchItem(student: students[index], index: index);
      },
    );
  }
}
