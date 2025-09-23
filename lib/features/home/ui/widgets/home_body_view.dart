import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_header_bar.dart';

class HomeBodyView extends StatefulWidget {
  const HomeBodyView({super.key});

  @override
  State<HomeBodyView> createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  @override
  void initState() {
    context.read<LevelCubit>().streamGetLevels();
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
                'All Levels: ',
                style: AppTextStyles.styleBold28sp(
                  context,
                ).copyWith(color: ColorsTheme().primaryDark),
              ),
            ),
          ),
          BlocBuilder<LevelCubit, LevelState>(
            builder: (context, state) {
              if (state is LevelGetAllLevelsError) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.error)),
                );
              } else if (state is LevelGetAllLevelsSuccess &&
                  context.read<LevelCubit>().levels.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No levels found, add new level',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.styleBold24sp(
                        context,
                      ).copyWith(color: ColorsTheme().grayWhite),
                    ),
                  ),
                );
              } else {
                {
                  final levels = context.read<LevelCubit>().levels;
                  return SliverList.builder(
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsTheme().primaryDark,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            textColor: ColorsTheme().whiteColor,
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: ColorsTheme().secondaryColor,
                              child: Text(
                                '${index + 1}',
                                style: AppTextStyles.styleBold24sp(
                                  context,
                                ).copyWith(color: ColorsTheme().whiteColor),
                              ),
                            ),
                            title: Text(
                              level.name,
                              style: AppTextStyles.styleBold24sp(context),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: ColorsTheme().whiteColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
