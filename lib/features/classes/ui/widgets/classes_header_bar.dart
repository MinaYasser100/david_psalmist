import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'add_class_button.dart';

class ClassesHeaderBar extends StatefulWidget {
  const ClassesHeaderBar({
    super.key,
    required this.levelId,
    required this.levelName,
  });
  final String levelId;
  final String levelName;
  @override
  State<ClassesHeaderBar> createState() => _ClassesHeaderBarState();
}

class _ClassesHeaderBarState extends State<ClassesHeaderBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70.0,
      backgroundColor: ColorsTheme().whiteColor,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Card(
          elevation: 2,
          color: ColorsTheme().whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ClassesHeaderTitle(),
                    AddClassButton(
                      controller: _controller,
                      focusNode: _focusNode,
                      levelId: widget.levelId,
                      levelName: widget.levelName,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ClassesHeaderTitle extends StatelessWidget {
  const ClassesHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.layers, color: ColorsTheme().primaryDark),
        const SizedBox(width: 8),
        Text(
          "Add a new class".tr(),
          style: AppTextStyles.styleBold18sp(
            context,
          ).copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
