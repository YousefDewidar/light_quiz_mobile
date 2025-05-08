import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/features/auth/data/repo/auth_repo.dart';
import 'package:light_quiz/features/auth/ui/managers/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    Either<Failure, void> response = await authRepo.signIn(
      email: email,
      password: password,
    );

    response.fold(
      (failuer) {
        emit(LoginFailure(message: failuer.errMessage));
      },
      (success) {
        emit(LoginSuccess());
      },
    );
  }
}
