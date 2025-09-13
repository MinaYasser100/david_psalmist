import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/validation/validatoin.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.adminController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.adminFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController adminController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode adminFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Login",
          style: AppTextStyles.styleBold30sp(
            context,
          ).copyWith(color: ColorsTheme().primaryDark),
        ),
        Text(
          'Sign in to continue',
          style: AppTextStyles.styleBold16sp(
            context,
          ).copyWith(color: ColorsTheme().grayWhite),
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
              FocusScope.of(context).requestFocus(adminFocusNode);
            },
          ),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            keyboardType: TextInputType.visiblePassword,
            controller: adminController,
            labelText: "Admin Password",
            hintText: "Enter Admin Password",
            icon: Icons.lock,
            obscureText: true,
            validator: (value) => Validatoin.validatePassword(value),
            focusNode: adminFocusNode,
            onFieldSubmitted: (value) {
              adminFocusNode.unfocus();
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
