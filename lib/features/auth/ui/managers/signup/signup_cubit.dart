import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:light_quiz/features/auth/data/repo/auth_repo.dart'
    show AuthRepo;
import 'package:light_quiz/features/auth/ui/managers/signup/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRepo authRepo;
  SignupCubit(this.authRepo) : super(SignupInitial());

  Future<void> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignupLoading());

    final response = await authRepo.signup(
      email: email,
      password: password,
      name: name,
    );

    response.fold(
      (failuer) {
        emit(SignupFailure(message: failuer.errMessage));
      },
      (user) {
        emit(SignupSuccess());
      },
    );
  }

  void rebuidButton() {
    emit(SignupInitial());
  }
}
