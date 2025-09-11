import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({super.key, required this.textFieldModel});

  final TextFieldModel textFieldModel;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.textFieldModel.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textFieldModel.controller,
      cursorColor: ColorsTheme().whiteColor,
      validator: widget.textFieldModel.validator,
      autovalidateMode: widget.textFieldModel.autovalidateMode,
      obscureText: isObscured,
      keyboardType: widget.textFieldModel.keyboardType,
      autofocus: widget.textFieldModel.autofocus,
      focusNode: widget.textFieldModel.focusNode,
      onFieldSubmitted: widget.textFieldModel.onFieldSubmitted,
      style: TextStyle(color: ColorsTheme().whiteColor),
      decoration: InputDecoration(
        labelText: widget.textFieldModel.labelText,
        hintText: widget.textFieldModel.hintText,
        errorText: widget.textFieldModel.errorText,
        hintStyle: TextStyle(color: ColorsTheme().grayWhite),
        labelStyle: TextStyle(color: ColorsTheme().whiteColor),
        prefixIcon: Icon(
          widget.textFieldModel.icon,
          size: 22,
          color: ColorsTheme().whiteColor,
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 40, // علشان الأيقونة تبقى في النص
          minWidth: 40,
        ),
        suffixIcon: widget.textFieldModel.obscureText
            ? GestureDetector(
                onTap: () {
                  isObscured = !isObscured;
                  setState(() {});
                },
                child: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: ColorsTheme().whiteColor,
                ),
              )
            : null,
        border: _customOutlineInputBorder(),
        focusedBorder: _customOutlineInputBorder(),
        enabledBorder: _customOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _customOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: ColorsTheme().whiteColor),
    );
  }
}
