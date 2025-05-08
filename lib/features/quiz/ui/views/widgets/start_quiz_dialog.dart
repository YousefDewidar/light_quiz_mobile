import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/features/quiz/data/models/quiz_meta_data.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_state.dart';

class StartQuizDialog extends StatelessWidget {
  final QuizMetaData metaData;
  final QuizState state;
  const StartQuizDialog({
    super.key,
    required this.metaData,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.lightPrimaryColor.withOpacity(0.7),
                  ],
                ),
              ),
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              metaData.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              'from yousef',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),

            const SizedBox(height: 24),

            // Meta Info
            _infoBox(
              'Time Allowed:',
              '${metaData.timeAllowed} minutes',
              Colors.blue.withOpacity(0.08),
              Colors.blue,
              context,
            ),
            const SizedBox(height: 10),
            _infoBox(
              'Questions:',
              '${metaData.numberOfQuestions}',
              Colors.purple.withOpacity(0.08),
              Colors.purple,
              context,
            ),
            const SizedBox(height: 10),
            _infoBox(
              'Starts At:',
              '${metaData.startsAt.day}-${metaData.startsAt.month}-${metaData.startsAt.year} | ${metaData.startsAt.hour}:${metaData.startsAt.minute}',
              Colors.blue.withOpacity(0.08),
              Colors.blue,
              context,
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: const Color.fromARGB(255, 183, 183, 183),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: CustomButton(
                    title: "Start Quiz",
                    onPressed: () async {
                      await context.read<QuizCubit>().loadQuiz(
                        examCode: metaData.quizId,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },

                    isLoading: state is QuizLoading,

                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(
    String label,
    String value,
    Color bgColor,
    Color labelColor,
    context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: labelColor,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).textTheme.bodySmall!.color!,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
