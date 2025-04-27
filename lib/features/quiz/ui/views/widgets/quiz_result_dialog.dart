import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/ui/cubits/response_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/response_state.dart';

class QuizResultDialog extends StatelessWidget {
  final Result result;
  final String shortCode;
  const QuizResultDialog({
    super.key,
    required this.result,
    required this.shortCode,
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
            // Gradient Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.blue],
                ),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Quiz Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle (Quiz title)
            Text(
              result.quizTitle,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodySmall!.color,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            // Info Boxes
            _infoBox('🎯 Grade:', '${result.grade}'),
            const SizedBox(height: 10),
            _infoBox('📊 Possible Points:', '${result.possiblePoints}'),
            const SizedBox(height: 10),
            _infoBox(
              '✅ Correct:',
              '${result.correctQuestions}/${result.totalQuestions}',
            ),

            const SizedBox(height: 24),

            // Button to view answers
            SizedBox(
              width: double.infinity,
              child: BlocListener<ResponseCubit, ResponseState>(
                listener: (context, state) {},
                child: ElevatedButton(
                  onPressed: () async {
                    await context.read<ResponseCubit>().getResposes(
                      context,
                      shortCode: shortCode,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Show Responses"),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color.fromARGB(255, 232, 200, 200),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
