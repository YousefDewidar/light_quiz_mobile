import 'package:light_quiz/features/quiz/data/models/correct_quiz_model.dart';
import 'package:light_quiz/features/quiz/data/models/quiz.dart';
import 'package:light_quiz/features/quiz/data/models/quiz_meta_data.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizSuccess extends QuizState {
  final Quiz quiz;
  QuizSuccess(this.quiz);
}

class QuizFail extends QuizState {
  final String message;
  QuizFail(this.message);
}

class QuizSubmitLoading extends QuizState {}

class QuizSubmitSuccess extends QuizState {}

class QuizSubmitFailure extends QuizState {
  final String message;
  QuizSubmitFailure(this.message);
}

class QuizMetaDataLoading extends QuizState {}

class QuizMetaDataSuccess extends QuizState {
  final QuizMetaData metaData;
  QuizMetaDataSuccess(this.metaData);
}

class QuizResultLoading extends QuizState {}

class QuizResultSuccess extends QuizState {
  final Result result;
  QuizResultSuccess(this.result);
}

class ShowResponseSuccess extends QuizState {
  final CorrectedQuizModel results;
  ShowResponseSuccess(this.results);
}

class QuizResultListLoading extends QuizState {}

class QuizResultListSuccess extends QuizState {
  final List<Result> resultsList;
  QuizResultListSuccess(this.resultsList);
}
