import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeHeaderBar extends StatelessWidget {
  const HomeHeaderBar({super.key});

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
                CustomButton(text: 'Add', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
