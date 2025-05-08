import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/ui/managers/response_state.dart';
import 'package:light_quiz/features/quiz/ui/views/show_response_view.dart';

class ResponseCubit extends Cubit<ResponseState> {
  ResponseCubit(this.quizRepo) : super(ResponseInitial());
  QuizRepo quizRepo;

  Future<void> getResposes(context, {required String shortCode}) async {
    emit(ResponseLoading());
    final result = await quizRepo.getResponses(shortCode: shortCode);
    result.fold(
      (fail) {
        showNotification(context, fail.errMessage, NotiType.error);
        emit(ResponseFail(fail.errMessage));
      },

      (success) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShowResponseView(quiz: success),
          ),
        );
        emit(ResponseInitial());
      },
    );
  }
}
