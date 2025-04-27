import 'package:light_quiz/features/quiz/data/models/correct_option.dart';

class CorrectedQuestion {
  final String text;
  final int points;
  final String? studentAnswer;
  final String? studentOption;
  final String? correctOption;
  final bool isCorrect;
  final String? explanation;
  final List<CorrectedOption>? options;

  CorrectedQuestion({
    required this.text,
    required this.points,
    this.studentAnswer,
    this.studentOption,
    required this.isCorrect,
    this.explanation,
    this.options,
    this.correctOption,
  });

  factory CorrectedQuestion.fromJson(Map<String, dynamic> json) {
    return CorrectedQuestion(
      text: json['questionText'],
      points: json['points'],
      studentAnswer: json['studentAnsweredText'],
      studentOption: json['studentAnsweredOption'],
      isCorrect: json['isCorrect'],
      explanation: json['feedbackMessage'],
      correctOption: json['correctOption'],
      options:
          json['options'] != null
              ? (json['options'] as List)
                  .map((e) => CorrectedOption.fromJson(e))
                  .toList()
              : null,
    );
  }

  int get typeId =>
      options == null || options!.isEmpty
          ? 3 // essay
          : options!.length == 2
          ? 2 // true/false
          : 1; // mcq
}
