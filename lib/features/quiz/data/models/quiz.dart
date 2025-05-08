// ignore_for_file: public_member_api_docs, sort_constructors_first

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

