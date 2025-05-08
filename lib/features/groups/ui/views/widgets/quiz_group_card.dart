import 'package:flutter/material.dart';
import 'package:light_quiz/features/groups/data/models/quiz_group_metadata.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/start_quiz_from_group.dart';

class QuizGroupCard extends StatelessWidget {
  const QuizGroupCard({super.key, required this.quiz});

  final QuizGroupMetaData quiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final quizEndTime = quiz.startsAt.add(Duration(minutes: quiz.timeAllowed));
    final bool isExpired = quizEndTime.isBefore(now);
    final bool notStartedYet = quiz.startsAt.isAfter(now);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isExpired
                  ? Colors.red.withOpacity(0.2)
                  : notStartedYet
                  ? Colors.orange.withOpacity(0.2)
                  : theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    isExpired
                        ? Colors.red
                        : notStartedYet
                        ? Colors.orange
                        : theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questions: ${quiz.numberOfQuestions}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                Text(
                  'Points: ${quiz.possiblePoints}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Duration: ${quiz.timeAllowed} minutes',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Exam Date: ${quiz.startsAt.toString().substring(0, 16)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color:
                    isExpired
                        ? Colors.red
                        : notStartedYet
                        ? Colors.orange
                        : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                      isExpired || quiz.didStartQuiz || notStartedYet
                          ? theme.colorScheme.surfaceVariant
                          : theme.colorScheme.primary,
                ),
                onPressed:
                    isExpired || quiz.didStartQuiz || notStartedYet
                        ? null
                        : () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return StartQuizFromGroup(metaData: quiz);
                            },
                          );
                        },
                child: Text(
                  isExpired
                      ? 'Expired'
                      : notStartedYet
                      ? 'Not Started Yet'
                      : quiz.didStartQuiz
                      ? 'Already Started'
                      : 'Start Quiz',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color:
                        isExpired || quiz.didStartQuiz || notStartedYet
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
