import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscuringCharacter,
    required this.keyBoardType,
    this.onChange,
    this.suffixIcon,
    this.suffixPressed,
    this.onFieldSubmitted,
    required this.valedate,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.obscureText,
    this.autoValidate = false,
  });

  final TextEditingController controller;
  final String? obscuringCharacter;
  final TextInputType keyBoardType;
  final ValueChanged<String>? onChange;
  final Widget? suffixIcon;
  final VoidCallback? suffixPressed;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String> valedate;
  final bool? obscureText;
  final AutovalidateMode autoValidateMode;
  final GestureTapCallback? onTap;
  final String hintText;
  final bool? autoValidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      autovalidateMode: autoValidate == true ? autoValidateMode : null,
      keyboardType: keyBoardType,
      onFieldSubmitted: onFieldSubmitted,
      validator: valedate,
      obscureText: obscureText ?? false,
      onTap: onTap,
      obscuringCharacter: obscuringCharacter ?? '.',
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: suffixIcon!,
              )
            : null,
        hintText: hintText,
        hintStyle: AppTextStyles.styleMedium16sp(context),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFDCDCDC),
      ),
    );
  }
}
