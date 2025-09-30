import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_animated_text_kit.dart';
import 'package:david_psalmist/features/classes/manager/class_cubit/class_cubit.dart';
import 'package:david_psalmist/features/classes/ui/widgets/classes_header_bar.dart';
import 'package:david_psalmist/features/classes/ui/widgets/class_list_item.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassesBodyView extends StatefulWidget {
  const ClassesBodyView({super.key, required this.level});
  final LevelModel level;

  @override
  State<ClassesBodyView> createState() => _ClassesBodyViewState();
}

class _ClassesBodyViewState extends State<ClassesBodyView> {
  @override
  void initState() {
    context.read<ClassesCubit>().getClasses(levelId: widget.level.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          ClassesHeaderBar(levelId: widget.level.id),

          BlocConsumer<ClassesCubit, ClassesState>(
            listener: (context, state) {
              if (state is ClassError) {
                showErrorToast(context, 'Error'.tr(), state.message);
              }
            },
            builder: (context, state) {
              if (state is ClassLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is GetAllClassesSuccess) {
                final classes = state.classes;
                if (classes.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CustomAnimatedTextKit(
                        text: 'No classes yet, add a new class to get started!'
                            .tr(),
                      ),
                    ),
                  );
                }

                return SliverList.builder(
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final classModel = classes[index];
                    return ClassListItem(classModel: classModel);
                  },
                );
              }

              // default - safe fallback
              final classes = context.read<ClassesCubit>().classes;
              if (classes.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text('No classes yet'.tr())),
                );
              }

              return SliverList.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final classModel = classes[index];
                  return ClassListItem(classModel: classModel);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
