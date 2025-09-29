import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_no_levels_widget.dart';
import 'custom_sliver_levels_list.dart';
import 'home_header_bar.dart';

class HomeBodyView extends StatefulWidget {
  const HomeBodyView({super.key});

  @override
  State<HomeBodyView> createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  @override
  void initState() {
    context.read<LevelCubit>().getLevels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: CustomScrollView(
        slivers: [
          HomeHeaderBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "allLevels".tr(),
                style: AppTextStyles.styleBold28sp(
                  context,
                ).copyWith(color: ColorsTheme().primaryDark),
              ),
            ),
          ),
          BlocConsumer<LevelCubit, LevelState>(
            listener: (context, state) {
              if (state is LevelError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: ColorsTheme().errorColor,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LevelGetAllLevelsSuccess &&
                  context.read<LevelCubit>().levels.isEmpty) {
                return CustomNoLevelsWidget();
              } else {
                {
                  final levels = context.read<LevelCubit>().levels;
                  return CustomSliverLevelsList(levels: levels);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
