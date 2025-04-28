import 'package:cached_network_image/cached_network_image.dart';
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
      shadowColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : const Color.fromARGB(255, 247, 247, 247),
      color: Theme.of(context).textTheme.bodyMedium!.color,
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodySmall!.color,
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
            const SizedBox(height: 12),
            if (question.imageUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: question.imageUrl!,
                    height: 290,
                    fit: BoxFit.fill,
                    errorListener: (value) {
                      return;
                    },
                    errorWidget:
                        (context, url, error) =>
                            Center(child: const Icon(Icons.error)),
                    placeholder:
                        (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                  ),
                ),
              ),
            const SizedBox(height: 12),

            if (question.typeId == 1 || question.typeId == 2)
              McqOptionsListView(
                question: question,
                answers: answers,
                qIndex: qIndex,
              )
            else if (question.typeId == 3)
              TextField(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Your answer here...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.3,
                    ),
                  ),
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
