class QuizMetaData {
  final String quizId;
  final String title;
  final String description;
  final int timeAllowed;
  final DateTime startsAt;
  final int numberOfQuestions;
  final bool didStartQuiz;

  QuizMetaData({
    required this.quizId,
    required this.title,
    required this.description,
    required this.timeAllowed,
    required this.startsAt,
    required this.numberOfQuestions,
    required this.didStartQuiz,
  });

  factory QuizMetaData.fromJson(Map<String, dynamic> json) => QuizMetaData(
    quizId: json['quizId'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    timeAllowed: json['timeAllowed'] as int,
    startsAt: DateTime.parse(json['startsAt'] as String),
    numberOfQuestions: json['numberOfQuestions'] as int,
    didStartQuiz: json['didStartQuiz'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'quizId': quizId,
    'title': title,
    'description': description,
    'timeAllowed': timeAllowed,
    'startsAt': startsAt.toIso8601String(),
    'numberOfQuestions': numberOfQuestions,
    'didStartQuiz': didStartQuiz,
  };
}
