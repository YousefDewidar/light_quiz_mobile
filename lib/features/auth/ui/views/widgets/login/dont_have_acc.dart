import 'package:flutter/material.dart';

import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';
import 'package:light_quiz/features/auth/ui/views/signup_view.dart';

class DontHaveAcc extends StatelessWidget {
  const DontHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont Have An Account",
          style: TextStyles.semiBold16.copyWith(color: AppColors.greyColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupView()),
            );
          },
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 5),
            ),
          ),
          child: Text(
            "Sign Up",
            style: TextStyles.semiBold16.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
