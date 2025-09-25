import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_level_item_view.dart';

class CustomSliverLevelsList extends StatelessWidget {
  const CustomSliverLevelsList({super.key, required this.levels});

  final List<LevelModel> levels;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Dismissible(
            key: Key(level.id),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                color: ColorsTheme().errorColor,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              final result = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Delete Level',
                  content: 'Are you sure you want to delete ${level.name}?',
                  nameOfNegativeButton: 'No',
                  nameOfPositiveButton: 'Yes',
                  onNegativeButtonPressed: () =>
                      Navigator.of(context).pop(false),
                  onPositiveButtonPressed: () =>
                      Navigator.of(context).pop(true),
                ),
              );
              return result ?? false;
            },
            onDismissed: (direction) {
              final cubit = context.read<LevelCubit>();
              // اشيله من الليست الأول
              cubit.levels.removeWhere((l) => l.id == level.id);
              // بعدين احذف من Firebase أو غيره
              cubit.deleteLevel(levelId: level.id);
              showSuccessToast(
                context,
                'Success',
                'Level deleted successfully',
              );
            },
            child: GestureDetector(
              onTap: () {
                context.push(Routes.classesView, extra: level);
              },
              child: CustomLevelItemView(level: level, index: index),
            ),
          ),
        );
      },
    );
  }
}
