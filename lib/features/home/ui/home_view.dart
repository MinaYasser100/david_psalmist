import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/features/home/ui/widgets/home_body_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = UserHiveHelper.getUser(ConstantVariable.uId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('welcomeMessage'.tr()),
            const SizedBox(width: 8),
            Text('${userModel?.firstName}'),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.settingsView);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const HomeBodyView(),
    );
  }
}

// IconButton(
//             onPressed: () {
//               showDialog(
//                 barrierColor: ColorsTheme().grayWhite.withValues(alpha: 0.3),
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (context) => CustomAlertDialog(
//                   title: 'Logout',
//                   content: 'Are you sure you want to logout?',
//                   nameOfNegativeButton: 'Cancel',
//                   nameOfPositiveButton: 'Logout',
//                   onNegativeButtonPressed: () => Navigator.pop(context),
//                   onPositiveButtonPressed: () async {},
//                 ),
//               );
//             },
//             icon: const Icon(Icons.logout),
//           ),
