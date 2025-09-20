import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/register/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/register/manager/register_cubit/register_cubit.dart';
import 'package:david_psalmist/features/verfiy_email/ui/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameController,
    required this.lastNameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VerifyEmailView()),
          );
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
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
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
