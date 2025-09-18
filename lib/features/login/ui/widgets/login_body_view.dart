import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/login/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/login/manager/cubit/login_cubit.dart';
import 'package:david_psalmist/features/login/ui/widgets/login_form_fields.dart';
import 'package:david_psalmist/features/login/ui/widgets/login_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.adminController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.adminFocusNode,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController adminController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode adminFocusNode;

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
                  LoginFormFields(
                    emailController: emailController,
                    passwordController: passwordController,
                    adminController: adminController,
                    emailFocusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    adminFocusNode: adminFocusNode,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.push(Routes.forgotPasswordView);
                        },
                        child: Text(
                          "Forgot password?",
                          style: AppTextStyles.styleBold16sp(context),
                        ),
                      ),
                    ],
                  ),
                  LoginSubmitButton(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    adminController: adminController,
                  ),
                  const SizedBox(height: 16),

                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginError) {
                        showErrorToast(context, 'Error', state.error);
                      }
                      if (state is LoginSuccess) {
                        showSuccessToast(
                          context,
                          'Success',
                          'Login Process is Successful',
                        );
                        context.go(Routes.homeView);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsTheme().primaryDark,
                            padding: EdgeInsets.all(0),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  'assets/image/google.jpg',
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Sign in with Google',
                                  style: AppTextStyles.styleBold16sp(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.styleBold16sp(context),
                      ),
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.push(Routes.registerView);
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.styleBold16sp(context),
                        ),
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
