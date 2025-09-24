import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomLevelItemView(level: level, index: index),
        );
      },
    );
  }
}
