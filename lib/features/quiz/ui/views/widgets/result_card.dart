import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/ui/managers/response_cubit.dart';

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

          CustomButton(
            height: 40,
            title: "View Answers",
            color: Colors.blueAccent,
            onPressed: () async {
              // log(result.quizShortCode);
              await context.read<ResponseCubit>().getResposes(
                context,
                shortCode: result.quizShortCode,
              );
            },
          ),
        ],
      ),
    );
  }
}
