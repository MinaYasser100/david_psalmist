import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDontAccount extends StatelessWidget {
  const CustomDontAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.styleBold16sp(context),
        ),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.push(Routes.registerView);
          },
          child: Text("Sign Up", style: AppTextStyles.styleBold16sp(context)),
        ),
      ],
    );
  }
}
