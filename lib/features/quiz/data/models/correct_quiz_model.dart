import 'package:light_quiz/features/quiz/data/models/corrected_question.dart';

class CorrectedQuizModel {
  final String quizId;
  final String shortCode;
  final String title;
  final String description;
  final int grade;
  final int possiblePoints;
  final int correctQuestions;
  final int totalQuestions;
  final DateTime submissionDate;
  final DateTime gradingDate;
  final List<CorrectedQuestion> questions;

  CorrectedQuizModel({
    required this.quizId,
    required this.shortCode,
    required this.title,
    required this.description,
    required this.grade,
    required this.possiblePoints,
    required this.correctQuestions,
    required this.totalQuestions,
    required this.submissionDate,
    required this.gradingDate,
    required this.questions,
  });

  factory CorrectedQuizModel.fromJson(Map<String, dynamic> json) {
    return CorrectedQuizModel(
      quizId: json['quizId'],
      shortCode: json['shortCode'],
      title: json['title'],
      description: json['description'],
      grade: json['grade'],
      possiblePoints: json['possiblePoints'],
      correctQuestions: json['correctQuestions'],
      totalQuestions: json['totalQuestions'],
      submissionDate: DateTime.parse(json['submissionDate']),
      gradingDate: DateTime.parse(json['gradingDate']),
      questions:
          (json['questions'] as List)
              .map((e) => CorrectedQuestion.fromJson(e))
              .toList(),
    );
  }
}
