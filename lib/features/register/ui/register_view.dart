import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/features/register/data/repo/register_repo_impl.dart';
import 'package:david_psalmist/features/register/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/register/manager/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/register_body_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(
          create: (context) => RegisterCubit(getIt<RegisterRepoImpl>()),
        ),
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
            RegisterBodyView(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              emailFocusNode: emailFocusNode,
              passwordFocusNode: passwordFocusNode,
              confirmPasswordFocusNode: confirmPasswordFocusNode,
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              firstNameFocusNode: firstNameFocusNode,
              lastNameFocusNode: lastNameFocusNode,
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
