import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/features/register/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/register/ui/widgets/register_form_fields.dart';
import 'package:david_psalmist/features/register/ui/widgets/register_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterBodyView extends StatelessWidget {
  const RegisterBodyView({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<AutovalidateModeCubit, AutovalidateModeState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              autovalidateMode: context
                  .read<AutovalidateModeCubit>()
                  .autovalidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegisterFormFields(
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    emailFocusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    confirmPasswordFocusNode: confirmPasswordFocusNode,
                  ),
                  RegisterSubmitButton(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.styleBold16sp(context),
                      ),
                      TextButton(
                        onPressed: () => context.go(Routes.loginView),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
