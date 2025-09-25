import 'package:david_psalmist/features/classes/ui/widgets/classes_hearder_bar.dart';
import 'package:david_psalmist/features/home/data/model/level_model.dart';
import 'package:flutter/widgets.dart';

class ClassesBodyView extends StatelessWidget {
  const ClassesBodyView({super.key, required this.level});
  final LevelModel level;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          ClassesHeaderBar(),
          SliverList.builder(itemBuilder: (context, index) {}, itemCount: 10),
        ],
      ),
    );
  }
}
