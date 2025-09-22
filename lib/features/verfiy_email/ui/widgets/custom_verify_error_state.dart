import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/verfiy_email/manager/cubit/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
