import 'package:david_psalmist/core/dependency_injection/set_up_dependencies.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/verfiy_email/data/repo/verify_email_repo_impl.dart';
import 'package:david_psalmist/features/verfiy_email/manager/cubit/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class CustomVerifyErrorState extends StatelessWidget {
  const CustomVerifyErrorState({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: ColorsTheme().errorColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: AppTextStyles.styleMedium20sp(
                context,
              ).copyWith(color: ColorsTheme().errorColor),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<VerifyEmailCubit>().resendVerificationEmail(),
              icon: const Icon(Icons.refresh),
              label: const Text('Resend Verification Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme().errorColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomVerifyWaitingState extends StatelessWidget {
  const CustomVerifyWaitingState({super.key, this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              size: 80,
              color: ColorsTheme().primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              message ??
                  'Please verify your email via the link sent to your inbox.',
              textAlign: TextAlign.center,
              style: AppTextStyles.styleMedium20sp(context),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<VerifyEmailCubit>().resendVerificationEmail(),
              icon: const Icon(Icons.refresh),
              label: const Text('Resend Verification Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme().primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
