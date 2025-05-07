import 'package:light_quiz/features/quiz/data/models/correct_option.dart';

class CorrectedQuestion {
  final String text;
  final num points;
  final String? studentAnswer;
  final String? studentOption;
  final String? correctOption;
  final bool isCorrect;
  final String? explanation;
  final String? imageUrl;
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
    this.imageUrl,
  });

  int get typeId =>
      options == null || options!.isEmpty
          ? 3 // essay
          : options!.length == 2
          ? 2 // true/false
          : 1; // mcq

  factory CorrectedQuestion.fromMap(Map<String, dynamic> map) {
    return CorrectedQuestion(
      text: map['questionText'] as String,
      points: map['points'] as num,
      studentOption:
          map['studentAnsweredOption'] != null
              ? map['studentAnsweredOption'] as String
              : null,
      studentAnswer:
          map['studentAnsweredText'] != null
              ? map['studentAnsweredText'] as String
              : null,
      correctOption:
          map['correctOption'] != null ? map['correctOption'] as String : null,
      isCorrect: map['isCorrect'] as bool,
      explanation:
          map['feedbackMessage'] != null
              ? map['feedbackMessage'] as String
              : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      options:
          map['options'] != null
              ? List<CorrectedOption>.from(
                (map['options'] as List).map<CorrectedOption>(
                  (x) => CorrectedOption.fromJson(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }
}
