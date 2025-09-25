import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/custom_add_new_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassesHeaderBar extends StatefulWidget {
  const ClassesHeaderBar({super.key});

  @override
  State<ClassesHeaderBar> createState() => _ClassesHeaderBarState();
}

class _ClassesHeaderBarState extends State<ClassesHeaderBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70.0,
      backgroundColor: ColorsTheme().whiteColor,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Card(
          elevation: 2,
          color: ColorsTheme().whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.layers, color: ColorsTheme().primaryDark),
                        const SizedBox(width: 8),
                        Text(
                          'Add a new class',
                          style: AppTextStyles.styleBold18sp(
                            context,
                          ).copyWith(color: Colors.black87),
                        ),
                      ],
                    ),
                    BlocConsumer<LevelCubit, LevelState>(
                      listener: (context, state) {
                        if (state is LevelError) {
                          showErrorToast(context, 'Error', state.error);
                        }
                        if (state is LevelLoaded) {
                          showSuccessToast(
                            context,
                            'Success',
                            'Level Really Added',
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text: 'Add',
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CustomAddNewItem(
                                nameLevelController: _controller,
                                nameLevelFocusNode: _focusNode,
                                title: 'Add a new class',
                                nameOfNegativeButton: 'Cancel',
                                nameOfPositiveButton: 'Add',
                                labelText: 'Name of class',
                                onNegativeButtonPressed: () =>
                                    Navigator.pop(context),
                                onPositiveButtonPressed: () {
                                  if (_controller.text.trim().isEmpty) {
                                    _focusNode.unfocus();
                                    showErrorToast(
                                      context,
                                      'Error',
                                      'Please enter a name',
                                    );
                                  } else {
                                    // Add the new level using the cubit
                                    _controller.clear();
                                    _focusNode.unfocus();
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
