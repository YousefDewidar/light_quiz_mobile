// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubmitQuizModel {
  String quizId;
  String? studentId;
  List<Answers>? answers;

  SubmitQuizModel({required this.quizId, this.studentId, this.answers});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quizId'] = quizId;
    data['studentId'] = studentId;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SubmitQuizModel copyWith({
    String? quizId,
    String? studentId,
    List<Answers>? answers,
  }) {
    return SubmitQuizModel(
      quizId: quizId ?? this.quizId,
      studentId: studentId ?? this.studentId,
      answers: answers ?? this.answers,
    );
  }
}

class Answers {
  String questionId;
  String? optionLetter;
  String? answerText;

  Answers({required this.questionId, this.optionLetter, this.answerText});

  Answers.fromJson(Map<String, dynamic> json)
    : questionId = json['questionId'] as String {
    optionLetter = json['optionLetter'];
    answerText = json['answerText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['optionLetter'] = optionLetter;
    data['answerText'] = answerText;
    return data;
  }

  Answers copyWith({
    String? questionId,
    String? optionLetter,
    String? answerText,
  }) {
    return Answers(
      questionId: questionId ?? this.questionId,
      optionLetter: optionLetter ?? this.optionLetter,
      answerText: answerText ?? this.answerText,
    );
  }
}
