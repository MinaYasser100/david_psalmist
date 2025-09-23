import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:david_psalmist/features/home/data/repo/level_repo_impl.dart';
import 'package:david_psalmist/features/home/manager/level_cubit/level_cubit.dart';
import 'package:david_psalmist/features/home/ui/widgets/home_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LevelCubit(getIt<LevelRepoImpl>())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${userModel?.firstName}...'),
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
        body: const HomeBodyView(),
      ),
    );
  }
}
