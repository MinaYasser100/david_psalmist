import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'custom_add_new_level.dart';

class HomeHeaderBar extends StatefulWidget {
  const HomeHeaderBar({super.key});

  @override
  State<HomeHeaderBar> createState() => _HomeHeaderBarState();
}

class _HomeHeaderBarState extends State<HomeHeaderBar> {
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
      pinned: true,
      expandedHeight: 70.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Card(
          elevation: 2,
          color: ColorsTheme().whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers, color: ColorsTheme().primaryDark),
                    const SizedBox(width: 8),
                    Text(
                      'Add a new Level',
                      style: AppTextStyles.styleBold18sp(
                        context,
                      ).copyWith(color: Colors.black87),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Add',
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => CustomAddNewLevel(
                        nameLevelController: _controller,
                        nameLevelFocusNode: _focusNode,
                        title: 'Add a new Level',
                        nameOfNegativeButton: 'Cancel',
                        nameOfPositiveButton: 'Add',
                        onNegativeButtonPressed: () => Navigator.pop(context),
                        onPositiveButtonPressed: () {
                          if (_controller.text.trim().isEmpty) {
                            _focusNode.unfocus();
                            showErrorToast(
                              context,
                              'Error',
                              'Please enter a name',
                            );
                          } else {}
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
