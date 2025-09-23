import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

import 'home_header_bar.dart';

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({super.key});
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
                'All Levels : ',
                style: AppTextStyles.styleBold20sp(context),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
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
                      radius: 20,
                      backgroundColor: ColorsTheme().secondaryColor,
                      child: Text(
                        '$index',
                        style: AppTextStyles.styleBold24sp(
                          context,
                        ).copyWith(color: ColorsTheme().whiteColor),
                      ),
                    ),
                    title: Text(
                      'Level $index',
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
            itemCount: 25,
          ),
        ],
      ),
    );
  }
}
