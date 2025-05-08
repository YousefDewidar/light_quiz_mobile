class QuizGroupMetaData {
  final String quizId;
  final String shortCode;
  final String title;
  final String description;
  final int timeAllowed;
  final DateTime startsAt;
  final int numberOfQuestions;
  final int possiblePoints;
  final bool didStartQuiz;
  final String groupId;
  final bool anonymous;

  QuizGroupMetaData({
    required this.quizId,
    required this.shortCode,
    required this.title,
    required this.description,
    required this.timeAllowed,
    required this.startsAt,
    required this.numberOfQuestions,
    required this.possiblePoints,
    required this.didStartQuiz,
    required this.groupId,
    required this.anonymous,
  });

  factory QuizGroupMetaData.fromJson(Map<String, dynamic> json) {
    return QuizGroupMetaData(
      quizId: json['quizId'],
      shortCode: json['shortCode'],
      title: json['title'],
      description: json['description'],
      timeAllowed: json['timeAllowed'],
      startsAt: DateTime.parse(json['startsAt']).toLocal(),
      numberOfQuestions: json['numberOfQuestions'],
      possiblePoints: json['possiblePoints'],
      didStartQuiz: json['didStartQuiz'],
      anonymous: json['anonymous'],
      groupId: json['groupId'],
    );
  }
}
