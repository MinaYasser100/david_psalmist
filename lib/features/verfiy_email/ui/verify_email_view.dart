import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/verfiy_email/data/repo/verify_email_repo_impl.dart';
import 'package:david_psalmist/features/verfiy_email/manager/cubit/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/custom_verify_error_state.dart';
import 'widgets/custom_verify_waiting_state.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailCubit(getIt<VerifyEmailRepoImpl>())
        ..checkEmailVerification()
        ..startVerificationCheck(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Verify Your Email')),
        body: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              Future.delayed(const Duration(seconds: 2), () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showSuccessToast(context, 'Success', 'Email verified!');
                  context.go(Routes.loginView);
                });
              });
            }
          },
          child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
            builder: (context, state) {
              if (state is VerifyEmailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is VerifyEmailSuccess) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified, color: Colors.green, size: 80),
                      SizedBox(height: 20),
                      Text(
                        'Email verified!\nRedirecting...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is VerifyEmailWaiting) {
                return CustomVerifyWaitingState(message: state.message);
              } else if (state is VerifyEmailError) {
                return CustomVerifyErrorState(error: state.error);
              }
              return const Center(child: Text('Verify Email View'));
            },
          ),
        ),
      ),
    );
  }
}
