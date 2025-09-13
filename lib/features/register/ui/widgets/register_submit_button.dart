import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/register/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/register/manager/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.push(Routes.loginView);
          showSuccessToast(
            context,
            'Success',
            'Register Process is Successful',
          );
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
        if (state is RegisterError) {
          showErrorToast(context, 'Error', state.message);
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
              context.read<RegisterCubit>().registerWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
            } else {
              context.read<AutovalidateModeCubit>().changeAutovalidateMode();
            }
          },
          child: Text(
            "Register",
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
