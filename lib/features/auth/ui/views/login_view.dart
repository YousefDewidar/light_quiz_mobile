import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/core/widgets/layout_view.dart';
import 'package:light_quiz/features/auth/domain/repo/auth_repo.dart';
import 'package:light_quiz/features/auth/ui/managers/login/login_cubit.dart';
import 'package:light_quiz/features/auth/ui/managers/login/login_state.dart';
import 'package:light_quiz/features/auth/ui/views/widgets/login/login_view_body.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LayoutView()),
            );
          } else if (state is LoginFailure) {
            showNotification(context, state.message, NotiType.error);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
            inAsyncCall: state is LoginLoading,
            child: Scaffold(body: LoginViewBody()),
          );
        },
      ),
    );
  }
}
