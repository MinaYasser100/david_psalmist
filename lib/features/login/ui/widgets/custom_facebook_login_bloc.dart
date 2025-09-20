import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/login/manager/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_image_and_text_button.dart';

class CustomFaceBookLoginBloc extends StatelessWidget {
  const CustomFaceBookLoginBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showErrorToast(context, 'Error', state.error);
        }
        if (state is LoginSuccess) {
          showSuccessToast(context, 'Success', 'Login Process is Successful');
          context.go(Routes.homeView);
        }
      },
      builder: (context, state) {
        return CustomImageAndTextButton(
          image: 'assets/image/facebook.png',
          text: 'Sign in with Facebook',
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<LoginCubit>().loginWithGoogle();
          },
        );
      },
    );
  }
}
