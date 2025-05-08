import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/groups/data/models/quiz_group_metadata.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/start_quiz_from_group.dart';
import 'package:light_quiz/features/quiz/ui/managers/response_cubit.dart';

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
      shape: _cardBorder(isExpired, notStartedYet, theme),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _quizInfo(theme, isExpired, notStartedYet),

            if (!isExpired)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                      notStartedYet
                          ? theme.colorScheme.surfaceVariant
                          : theme.colorScheme.primary,
                ),
                onPressed:
                    notStartedYet
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
                  notStartedYet ? 'Not Started Yet' : 'Start Quiz',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color:
                        notStartedYet
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            if (isExpired)
              ElevatedButton(
                onPressed: () async {
                  await context.read<ResponseCubit>().getResposes(
                    context,
                    shortCode: quiz.shortCode,
                  );
                },

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  "View Your Result",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _cardBorder(
    bool isExpired,
    bool notStartedYet,
    ThemeData theme,
  ) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color:
            notStartedYet
                ? Colors.orange.withOpacity(0.2)
                : theme.colorScheme.outline.withOpacity(0.2),
        width: 1,
      ),
    );
  }

  Column _quizInfo(ThemeData theme, bool isExpired, bool notStartedYet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                quiz.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      notStartedYet
                          ? Colors.orange
                          : AppColors.lightPrimaryColor,
                ),
              ),
            ),
            if (isExpired)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Exam Ended",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
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
          'Exam Date: ${quiz.startsAt.toString().substring(0, 10)} | ${quiz.startsAt.hour > 12 ? "${quiz.startsAt.hour - 12}:${quiz.startsAt.minute.toString().padLeft(2, '0')} PM" : "${quiz.startsAt.hour}:${quiz.startsAt.minute.toString().padLeft(2, '0')} AM"}',
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
      ],
    );
  }
}
