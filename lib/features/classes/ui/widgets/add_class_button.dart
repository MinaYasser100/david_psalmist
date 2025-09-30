import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/custom_add_new_level.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddClassButton extends StatelessWidget {
  const AddClassButton({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.levelId,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String levelId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassesCubit, ClassesState>(
      listener: (context, state) {
        if (state is ClassError) {
          showErrorToast(context, 'Error'.tr(), state.message);
        }
        if (state is ClassAdded) {
          showSuccessToast(context, 'Success'.tr(), "Class Really Added".tr());
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: 'add'.tr(),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CustomAddNewItem(
                nameLevelController: controller,
                nameLevelFocusNode: focusNode,
                title: "Add a new class".tr(),
                nameOfNegativeButton: 'cancel'.tr(),
                nameOfPositiveButton: 'add'.tr(),
                labelText: "Class Name".tr(),
                onNegativeButtonPressed: () => Navigator.pop(context),
                onPositiveButtonPressed: () {
                  if (controller.text.trim().isEmpty) {
                    focusNode.unfocus();
                    showErrorToast(
                      context,
                      'Error'.tr(),
                      "Please enter the name".tr(),
                    );
                  } else {
                    context.read<ClassesCubit>().addClass(
                      classModel: ClassModel(
                        id: Uuid().v4(),
                        name: controller.text,
                        levelId: levelId,
                      ),
                    );
                    controller.clear();
                    focusNode.unfocus();
                    Navigator.pop(context);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
