import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/forgot_password/ui/widgets/forgot_password_bady_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/forgot_password_repo_impl.dart';
import '../manager/cubit/forgot_password_cubit.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;
  late FocusNode emailFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AutovalidateModeCubit()),
        BlocProvider(
          create: (context) =>
              ForgotPasswordCubit(getIt<ForgotPasswordRepoImpl>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
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

            ForgotPasswordBadyView(
              emailController: emailController,
              emailFocusNode: emailFocusNode,
              formKey: formKey,
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
