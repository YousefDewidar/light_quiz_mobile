import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/core/widgets/custom_text_field.dart';
import 'package:light_quiz/features/auth/ui/managers/login/login_cubit.dart';
import 'package:light_quiz/features/auth/ui/views/widgets/login/dont_have_acc.dart';
import 'package:light_quiz/features/auth/ui/views/widgets/login/password_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/student_c.png", height: 200),
                const SizedBox(height: 30),
                Text(
                  "Light Quiz",
                  style: TextStyles.bold23.copyWith(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ),
                Text(
                  "Your AI-Powered Quiz Experience",
                  style: TextStyles.medium15.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailCon,
                  hint: "Enter your email address",
                ),
                const SizedBox(height: 16),
                PasswordField(controller: _passCon),
                const SizedBox(height: 25),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<LoginCubit>().login(
                        email: _emailCon.text,
                        password: _passCon.text,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  title: "Login",
                ),
                const SizedBox(height: 26),
                DontHaveAcc(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
