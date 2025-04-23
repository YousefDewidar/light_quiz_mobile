// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:light_quiz/features/quiz/data/models/option.dart';
import 'package:light_quiz/features/quiz/data/models/question.dart';

class Quiz {
  String quizId;
  String attemptId;
  String title;
  String description;
  String startsAtUTC;
  int durationMinutes;
  List<Questions> questions;
  Quiz({
    required this.quizId,
    required this.attemptId,
    required this.title,
    required this.description,
    required this.startsAtUTC,
    required this.durationMinutes,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> map) {
    return Quiz(
      quizId: map['quizId'] as String,
      attemptId: map['attemptId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      startsAtUTC: map['startsAtUTC'] as String,
      durationMinutes: map['durationMinutes'] as int,
      questions: List<Questions>.from(
        (map['questions'] as List).map<Questions>(
          (x) => Questions.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

Quiz getDummyQuiz() {
  return Quiz(
    quizId: 'dummyQuizId',
    attemptId: 'dummyAttemptId',
    title: 'Sample Quiz',
    description: 'This is a sample quiz description.',
    startsAtUTC: '2023-01-01T00:00:00Z',
    durationMinutes: 5,
    questions: [
      Questions(
        quizId: 'dummyQuizId',
        typeId: 3,
        questionId: 'q3',
        text: 'Explain the theory of relativity.',
        options: [],
        points: 5,
      ),
      Questions(
        quizId: 'dummyQuizId',
        typeId: 1,
        questionId: 'q1',
        text: 'What is the capital of France?',
        options: [
          Option(optionId: 'o1', optionText: 'Paris', optionLetter: 'A'),
          Option(optionId: 'o2', optionText: 'London', optionLetter: 'B'),
          Option(optionId: 'o3', optionText: 'Berlin', optionLetter: 'C'),
          Option(optionId: 'o4', optionText: 'Madrid', optionLetter: 'D'),
        ],
        points: 1,
      ),
      Questions(
        quizId: 'dummyQuizId',
        typeId: 1,
        questionId: 'q2',
        text: 'What is 2 + 2?',
        options: [
          Option(optionId: 'o1', optionText: '3', optionLetter: 'A'),
          Option(optionId: 'o2', optionText: '4', optionLetter: 'B'),
          Option(optionId: 'o3', optionText: '5', optionLetter: 'C'),
          Option(optionId: 'o4', optionText: '6', optionLetter: 'D'),
        ],
        points: 1,
      ),
    ],
  );
}
