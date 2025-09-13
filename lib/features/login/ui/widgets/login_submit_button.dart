import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/login/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/login/manager/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.adminController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController adminController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showErrorToast(context, 'Error', state.error);
        }
        if (state is LoginSuccess) {
          showSuccessToast(context, 'Success', 'Login Process is Successful');
          context.go(Routes.homeView);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsTheme().primaryDark,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              if (adminController.text == "Jesus1741") {
                context.read<LoginCubit>().loginWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
              } else {
                showErrorToast(context, 'Error', 'Admin Password is Incorrect');
              }
            } else {
              context.read<AutovalidateModeCubit>().changeAutovalidateMode();
            }
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: ColorsTheme().whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
