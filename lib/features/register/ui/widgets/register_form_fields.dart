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
    required this.firstNameController,
    required this.lastNameController,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;

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
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: firstNameController,
                  labelText: "First Name",
                  hintText: "Enter your first name",
                  icon: Icons.person,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  autofocus: true,
                  focusNode: firstNameFocusNode,
                  onFieldSubmitted: (value) {
                    firstNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(lastNameFocusNode);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFormField(
                textFieldModel: TextFieldModel(
                  controller: lastNameController,
                  labelText: "Last Name",
                  hintText: "Enter your first name",
                  icon: Icons.person,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  autofocus: true,
                  focusNode: lastNameFocusNode,
                  onFieldSubmitted: (value) {
                    lastNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          textFieldModel: TextFieldModel(
            controller: emailController,
            labelText: "Email",
            hintText: "Enter your email",
            icon: Icons.email,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validatoin.emailValidation(value),
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
