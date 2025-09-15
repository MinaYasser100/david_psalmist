import 'package:david_psalmist/core/model/text_field_model/text_field_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/validation/validatoin.dart';
import 'package:david_psalmist/core/widgets/custom_text_form_field.dart';
import 'package:david_psalmist/features/forgot_password/manager/autovalidate_mode/autovalidate_mode_cubit.dart';
import 'package:david_psalmist/features/forgot_password/manager/cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordBadyView extends StatelessWidget {
  const ForgotPasswordBadyView({
    super.key,
    required this.emailController,
    required this.emailFocusNode,
    required this.formKey,
  });
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: BlocBuilder<AutovalidateModeCubit, AutovalidateModeState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            autovalidateMode: context
                .read<AutovalidateModeCubit>()
                .autovalidateMode,
            child: Column(
              children: [
                Text(
                  'If you have forgotten your password, you can reset it here. Please enter your email address and we will send you a link to reset your password.',
                  style: AppTextStyles.styleBold20sp(
                    context,
                  ).copyWith(color: ColorsTheme().primaryDark),
                ),

                const SizedBox(height: 30),

                CustomTextFormField(
                  textFieldModel: TextFieldModel(
                    controller: emailController,
                    labelText: "Email",
                    hintText: "username@gmail.com",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validatoin.emailValidation(value),
                    autofocus: true,
                    focusNode: emailFocusNode,
                    onFieldSubmitted: (value) {
                      emailFocusNode.unfocus();
                    },
                  ),
                ),

                const SizedBox(height: 20),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordError) {
                      showErrorToast(context, 'Error', state.error);
                    }
                    if (state is ForgotPasswordSuccess) {
                      showSuccessToast(
                        context,
                        'Success',
                        'Password Reset Link Sent Successfully',
                      );
                      context.go(Routes.loginView);
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
                          context
                              .read<ForgotPasswordCubit>()
                              .sendPasswordResetEmail(
                                email: emailController.text.trim(),
                              );
                        } else {
                          context
                              .read<AutovalidateModeCubit>()
                              .changeAutovalidateMode();
                        }
                      },
                      child: const Text('Reset Password'),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
