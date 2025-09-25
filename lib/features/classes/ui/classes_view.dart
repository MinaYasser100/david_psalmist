import 'package:david_psalmist/features/classes/ui/widgets/classes_body_view.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:flutter/material.dart';

class ClassesView extends StatelessWidget {
  const ClassesView({super.key, required this.level});
  final LevelModel level;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(level.name)),
      body: ClassesBodyView(level: level),
    );
  }
}
