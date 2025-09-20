import 'package:david_psalmist/core/caching/hive/user_hive_helper.dart';
import 'package:david_psalmist/core/model/user_model/user_model.dart';
import 'package:david_psalmist/core/utils/constant.dart';
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
      appBar: AppBar(title: Text('Hi ${userModel?.firstName}')),
      body: const Center(child: Text('Welcome to the Home View!')),
    );
  }
}
