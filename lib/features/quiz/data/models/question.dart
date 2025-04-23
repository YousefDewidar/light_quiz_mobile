// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:light_quiz/features/quiz/data/models/option.dart';

class Questions {
  final String questionId;
  final String quizId;
  final String text;
  final int typeId;
  final int? points;
  final List<Option>? options;

  Questions({
    required this.questionId,
    required this.quizId,
    required this.text,
    required this.typeId,
    this.points,
    this.options,
  });

  factory Questions.fromMap(Map<String, dynamic> map) {
    return Questions(
      questionId: map['questionId'] as String,
      quizId: map['quizId'] as String,
      text: map['text'] as String,
      typeId: map['typeId'] as int,
      points: map['points'] != null ? map['points'] as int : null,
      options:
          map['options'] != null
              ? List<Option>.from(
                (map['options'] as List).map<Option?>(
                  (x) => Option.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  factory Questions.fromJson(String source) =>
      Questions.fromMap(json.decode(source) as Map<String, dynamic>);
}
