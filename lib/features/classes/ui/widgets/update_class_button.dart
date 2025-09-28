import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/custom_add_new_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateClassButton extends StatefulWidget {
  const UpdateClassButton({super.key, required this.classModel});
  final ClassModel classModel;
  @override
  State<UpdateClassButton> createState() => _UpdateClassButtonState();
}

class _UpdateClassButtonState extends State<UpdateClassButton> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.classModel.name;
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassesCubit, ClassesState>(
      listener: (context, state) {
        if (state is ClassError) {
          showErrorToast(context, 'Error', state.message);
        }
        if (state is ClassUpdated) {
          showSuccessToast(context, 'Success', 'Class Really Added');
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CustomAddNewItem(
                nameLevelController: controller,
                nameLevelFocusNode: focusNode,
                title: 'Update a class',
                nameOfNegativeButton: 'Cancel',
                nameOfPositiveButton: 'Update',
                labelText: 'Name of class',
                onNegativeButtonPressed: () => Navigator.pop(context),
                onPositiveButtonPressed: () {
                  if (controller.text.trim().isEmpty) {
                    focusNode.unfocus();
                    showErrorToast(context, 'Error', 'Please enter a name');
                  } else {
                    if (controller.text.trim() != widget.classModel.name) {
                      context.read<ClassesCubit>().updateClass(
                        classModel: ClassModel(
                          id: widget.classModel.id,
                          name: controller.text.trim(),
                          levelId: widget.classModel.levelId,
                        ),
                      );
                    }
                    controller.clear();
                    focusNode.unfocus();
                    Navigator.pop(context);
                  }
                },
              ),
            );
          },
          child: Icon(Icons.edit, color: Colors.white),
        );
      },
    );
  }
}
