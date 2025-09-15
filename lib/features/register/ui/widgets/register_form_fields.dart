import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/validation/validatoin.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Register",
          style: TextStyle(
            color: ColorsTheme().primaryDark,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Create an account",
          style: TextStyle(
            color: ColorsTheme().grayWhite,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: emailController,
            labelText: "Email",
            hintText: "Enter your email",
            icon: Icons.email,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validatoin.emailValidation(value),
            autofocus: true,
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
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
            focusNode: passwordFocusNode,
            onFieldSubmitted: (value) {
              passwordFocusNode.unfocus();
              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
            },
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
            validator: (value) => value != passwordController.text.trim()
                ? "Passwords do not match"
                : null,
            focusNode: confirmPasswordFocusNode,
            onFieldSubmitted: (value) {
              confirmPasswordFocusNode.unfocus();
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
