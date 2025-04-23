class Result {
  String studentId;
  String quizId;
  String quizTitle;
  int grade;
  int possiblePoints;
  int correctQuestions;
  int totalQuestions;

  Result({
    required this.studentId,
    required this.quizId,
    required this.quizTitle,
    required this.grade,
    required this.possiblePoints,
    required this.correctQuestions,
    required this.totalQuestions,
  });

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      studentId: map['studentId'] as String,
      quizId: map['quizId'] as String,
      quizTitle: map['quizTitle'] as String,
      grade: map['grade'] as int,
      possiblePoints: map['possiblePoints'] as int,
      correctQuestions: map['correctQuestions'] as int,
      totalQuestions: map['totalQuestions'] as int,
    );
  }


}
