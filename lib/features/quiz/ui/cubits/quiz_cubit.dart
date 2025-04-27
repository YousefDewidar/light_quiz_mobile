import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.quizRepo) : super(QuizInitial());
  QuizRepo quizRepo;

  Future<void> loadQuiz({required String examCode}) async {
    emit(QuizLoading());

    final quiz = await quizRepo.startAndGetQuiz(quizId: examCode);

    quiz.fold(
      (fail) => emit(QuizFail(fail.errMessage)),
      (success) => emit(QuizSuccess(success)),
    );
  }

  void getMetaData({required String shortCode}) async {
    emit(QuizMetaDataLoading());
    final metaData = await quizRepo.getQuizMetaData(shortCode: shortCode);
    metaData.fold(
      (fail) => emit(QuizFail(fail.errMessage)),
      (success) => emit(QuizMetaDataSuccess(success)),
    );
  }

  Future<void> submitAnswers({required SubmitQuizModel submitQuizModel}) async {
    emit(QuizSubmitLoading());

    final res = await quizRepo.submitQuiz(submitQuizModel: submitQuizModel);
    res.fold(
      (fail) {
        emit(QuizSubmitFailure(fail.errMessage));
      },
      (success) {
        emit(QuizSubmitSuccess());
      },
    );
  }

  Future<void> getResult({required String shortCode}) async {
    emit(QuizResultLoading());
    final result = await quizRepo.getResults(quizId: shortCode);
    result.fold(
      (fail) {
        emit(QuizFail(fail.errMessage));
      },

      (success) {
        emit(QuizResultSuccess(success));
      },
    );
  }


  Future<void> getResultsList() async {
    emit(QuizResultListLoading());
    final result = await quizRepo.getAllResults();
    result.fold(
      (fail) => emit(QuizFail(fail.errMessage)),
      (success) => emit(QuizResultListSuccess(success)),
    );
  }
}
