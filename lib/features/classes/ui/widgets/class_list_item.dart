import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_class_button.dart';

class ClassListItem extends StatelessWidget {
  const ClassListItem({super.key, required this.classModel, this.onTap});

  final ClassModel classModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
      child: Dismissible(
        key: Key(classModel.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          final result = await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Delete Class',
              content: 'Are you sure you want to delete ${classModel.name}?',
              nameOfNegativeButton: 'No',
              nameOfPositiveButton: 'Yes',
              onNegativeButtonPressed: () => Navigator.of(context).pop(false),
              onPositiveButtonPressed: () => Navigator.of(context).pop(true),
            ),
          );
          return result ?? false;
        },
        onDismissed: (direction) {
          final cubit = context.read<ClassesCubit>();
          // remove from local list first
          cubit.classes.removeWhere((c) => c.id == classModel.id);
          // then delete from remote
          cubit.deleteClass(classModel: classModel);
          showSuccessToast(context, 'Success', 'Level deleted successfully');
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primaryDark,
                theme.primaryDark,
                theme.primaryColor,
              ],
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 18.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      classModel.name,
                      style: AppTextStyles.styleBold16sp(
                        context,
                      ).copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  UpdateClassButton(classModel: classModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
