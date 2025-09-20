import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? userModel;
  @override
  initState() {
    super.initState();
    userModel = UserHiveHelper.getUser(ConstantVariable.uId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ${userModel?.firstName}...'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierColor: ColorsTheme().grayWhite.withValues(alpha: 0.3),
                barrierDismissible: false,
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Logout',
                  content: 'Are you sure you want to logout?',
                  nameOfNegativeButton: 'Cancel',
                  nameOfPositiveButton: 'Logout',
                  onNegativeButtonPressed: () => Navigator.pop(context),
                  onPositiveButtonPressed: () async {},
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Home View!')),
    );
  }
}
