import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_add_new_level.dart';

class HomeHeaderBar extends StatefulWidget {
  const HomeHeaderBar({super.key});

  @override
  State<HomeHeaderBar> createState() => _HomeHeaderBarState();
}

class _HomeHeaderBarState extends State<HomeHeaderBar> {
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
      pinned: true,
      expandedHeight: 70.0,
      backgroundColor: ColorsTheme().whiteColor,
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
                          'Add a new Level',
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
                              builder: (context) => CustomAddNewLevel(
                                nameLevelController: _controller,
                                nameLevelFocusNode: _focusNode,
                                title: 'Add a new Level',
                                nameOfNegativeButton: 'Cancel',
                                nameOfPositiveButton: 'Add',
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
                                    context.read<LevelCubit>().addLevel(
                                      _controller.text.trim(),
                                    );
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
