// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/quiz/data/models/correct_quiz_model.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/question_response_card.dart';

class ShowResponseView extends StatelessWidget {
  final CorrectedQuizModel quiz;

  const ShowResponseView({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Response",
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildScoreSummary(context),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  return CorrectedQuestionCard(
                    qIndex: index,
                    question: quiz.questions[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreSummary(BuildContext context) {
    return Card(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz Title
            Text(
              quiz.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
            ),
            const SizedBox(height: 8),

            // Submission Date
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppColors.lightPrimaryColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Submitted at: ${quiz.submissionDate.toString().split(' ')[0]} | ${quiz.submissionDate.toString().split(' ')[1].split('.')[0]}",
                    style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 6),
            // Total Score
            Row(
              children: [
                Icon(
                  (quiz.grade <= quiz.possiblePoints / 2)
                      ? Icons.close
                      : Icons.done,
                  size: 18,
                  color:
                      (quiz.grade <= quiz.possiblePoints / 2)
                          ? Colors.red
                          : AppColors.lightPrimaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  "Your Score: ",
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ),
                Text(
                  "${quiz.grade} / ${quiz.possiblePoints}",
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        (quiz.grade <= quiz.possiblePoints / 2)
                            ? Colors.red
                            : AppColors.lightPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
