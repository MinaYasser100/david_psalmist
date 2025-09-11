import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/validation/validatoin.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:david_psalmist/features/login/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

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
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsTheme().primaryDark,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registering...")),
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
