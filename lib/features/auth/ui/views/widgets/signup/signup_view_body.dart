import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/core/widgets/custom_text_field.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/auth/ui/managers/signup/signup_cubit.dart';
import 'package:light_quiz/features/auth/ui/managers/signup/signup_state.dart';
import 'package:light_quiz/features/auth/ui/views/login_view.dart';
import 'package:light_quiz/features/auth/ui/views/widgets/login/password_field.dart';
import 'package:light_quiz/features/auth/ui/views/widgets/signup/allready_have_acc.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  final TextEditingController _nameCon = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isTermsEnabeld = false;

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    _nameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                controller: _nameCon,
                hint: "Enter your full name",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailCon,
                hint: "Enter your email address",
              ),
              const SizedBox(height: 16),
              PasswordField(controller: _passCon),
              const SizedBox(height: 16),
              const SizedBox(height: 30),
              BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    showNotification(
                      context,
                      "Account created successfully",
                      NotiType.success,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: "Register",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SignupCubit>().signupWithEmailAndPassword(
                          email: _emailCon.text,
                          password: _passCon.text,
                          name: _nameCon.text,
                        );
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              AllreadyHaveAcc(),
            ],
          ),
        ),
      ),
    );
  }
}
