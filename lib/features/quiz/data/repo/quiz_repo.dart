import 'package:dartz/dartz.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/features/quiz/data/models/quiz.dart';
import 'package:light_quiz/features/quiz/data/models/quiz_meta_data.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';

abstract class QuizRepo {
  Future<Either<Failure, Quiz>> startAndGetQuiz({required String quizId});

  Future<Either<Failure, void>> submitQuiz({
    required SubmitQuizModel submitQuizModel,
  });

  Future<Either<Failure, QuizMetaData>> getQuizMetaData({
    required String shortCode,
  });

  Future<Either<Failure, Result>> getResults({required String quizId});

  Future<Either<Failure, List<Result>>> getAllResults();
}
