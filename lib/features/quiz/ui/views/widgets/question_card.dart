import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/quiz/data/models/question.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/mcq_options_list_view.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.qIndex,
    required this.question,
    required this.answers,
  });
  final int qIndex;
  final Questions question;
  final List<Answers> answers;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 247, 247, 247),
      color: const Color.fromARGB(255, 252, 254, 255),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Q${qIndex + 1}: ${question.text}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${question.points.toString()} pts",
                  style: TextStyle(color: AppColors.lightPrimaryColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (question.typeId == 1 || question.typeId == 2)
              McqOptionsListView(
                question: question,
                answers: answers,
                qIndex: qIndex,
              )
            else if (question.typeId == 3)
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter Your answer here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  answers[qIndex].answerText = value;
                },
              ),
          ],
        ),
      ),
    );
  }
}
