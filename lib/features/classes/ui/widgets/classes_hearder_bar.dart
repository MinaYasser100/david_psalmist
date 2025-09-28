import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/custom_add_new_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ClassesHeaderBar extends StatefulWidget {
  const ClassesHeaderBar({super.key, required this.levelId});
  final String levelId;
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
                    BlocConsumer<ClassesCubit, ClassesState>(
                      listener: (context, state) {
                        if (state is ClassError) {
                          showErrorToast(context, 'Error', state.message);
                        }
                        if (state is ClassAdded) {
                          showSuccessToast(
                            context,
                            'Success',
                            'Class Really Added',
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
                                    context.read<ClassesCubit>().addClass(
                                      classModel: ClassModel(
                                        id: Uuid().v4(),
                                        name: _controller.text,
                                        levelId: widget.levelId,
                                      ),
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
