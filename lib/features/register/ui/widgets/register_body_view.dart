import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/validation/validatoin.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:david_psalmist/features/register/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/register/manager/register_cubit/register_cubit.dart';
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
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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
                  CustomTextFormField(
                    textFieldModel: TextFieldModel(
                      controller: emailController,
                      labelText: "Email",
                      hintText: "Enter your email",
                      icon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validatoin.emailValidation(value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    textFieldModel: TextFieldModel(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      labelText: "Password",
                      hintText: "Enter your password",
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) => Validatoin.validatePassword(value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    textFieldModel: TextFieldModel(
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      labelText: "Confirm Password",
                      hintText: "Re-enter your password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) => value != passwordController.text
                          ? "Passwords do not match"
                          : null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        context.push(Routes.loginView);
                        showSuccessToast(
                          context,
                          'Success',
                          'Register Process is Successful',
                        );
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
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<RegisterCubit>()
                                .registerWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          } else {
                            context
                                .read<AutovalidateModeCubit>()
                                .changeAutovalidateMode();
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
