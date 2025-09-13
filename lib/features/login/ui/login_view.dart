import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/login/data/repo/login_repo_impl.dart';
import 'package:david_psalmist/features/login/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/login/manager/cubit/login_cubit.dart';
import 'package:david_psalmist/features/login/ui/widgets/login_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController adminController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode adminFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    adminController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    adminFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    adminController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    adminFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(create: (context) => LoginCubit(getIt<LoginRepoImpl>())),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            // Background decorations
            Positioned(
              top: -50,
              left: -50,
              child: _circleDecoration(
                120,
                ColorsTheme().primaryColor.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              top: 100,
              right: -40,
              child: _circleDecoration(
                100,
                ColorsTheme().secondaryLight.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              top: 450,
              left: -50,
              child: _circleDecoration(
                120,
                ColorsTheme().primaryColor.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              top: 350,
              right: -20,
              child: _circleDecoration(
                150,
                ColorsTheme().primaryDark.withValues(alpha: 0.2),
              ),
            ),

            Positioned(
              top: 140,
              left: -30,
              child: _rectangularCircleDecoration(),
            ),

            Positioned(
              top: 600,
              right: -30,
              child: _rectangularCircleDecoration(),
            ),
            // Form fields
            LoginBodyView(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController,
              adminController: adminController,
              emailFocusNode: emailFocusNode,
              passwordFocusNode: passwordFocusNode,
              adminFocusNode: adminFocusNode,
            ),
          ],
        ),
      ),
    );
  }

  Container _rectangularCircleDecoration() {
    return Container(
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: ColorsTheme().secondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }

  Widget _circleDecoration(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
