import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_state.dart';
import 'package:light_quiz/features/quiz/ui/views/show_response_view.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.isPassed, required this.result});

  final bool isPassed;
  final Result result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium!.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 7, 7, 7)
                    : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: isPassed ? Colors.green[100] : Colors.red[100],
                child: Icon(
                  isPassed ? Icons.check_circle : Icons.error_outline,
                  size: 30,
                  color: isPassed ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.quizTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Number of Questions: ${result.totalQuestions}",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${result.grade}/${result.possiblePoints}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          BlocListener<QuizCubit, QuizState>(
            listener: (context, state) {
              if (state is ShowResponseSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowResponseView(quiz: state.results),
                  ),
                );
              }
            },
            child: ElevatedButton(
              onPressed: () {},
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
        ],
      ),
    );
  }
}
