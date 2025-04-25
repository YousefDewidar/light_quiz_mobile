import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/quiz/data/models/corrected_question.dart';

class CorrectedQuestionCard extends StatelessWidget {
  const CorrectedQuestionCard({
    super.key,
    required this.qIndex,
    required this.question,
  });

  final int qIndex;
  final CorrectedQuestion question;

  @override
  Widget build(BuildContext context) {
    final isMcq = question.typeId == 1 || question.typeId == 2;

    return Card(
      shadowColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : const Color.fromARGB(255, 247, 247, 247),
      color: Theme.of(context).textTheme.bodyMedium!.color,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1.4,
          color: question.isCorrect ? Colors.green : Colors.red,
        ),
      ),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نص السؤال + الدرجة
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: question.isCorrect ? Colors.green : Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${question.isCorrect ? question.points : 0}/${question.points} pts',
                    style: TextStyle(
                      color: question.isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // الأسئلة MCQ
            if (isMcq && question.options != null)
              ListView.builder(
                itemCount: question.options!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final opt = question.options![index];

                  return Container(
                    decoration: _mcqDecoration(
                      isSelected: opt.optionLetter == question.studentOption,
                      isCorrect: question.isCorrect,
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: RadioListTile<String>(
                      title: Text(
                        opt.text,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).textTheme.bodySmall!.color!.withOpacity(0.8),
                        ),
                      ),
                      value: opt.optionLetter,
                      groupValue: question.studentOption,
                      activeColor: AppColors.secondaryColor,
                      onChanged: null,
                    ),
                  );
                },
              ),

            // الأسئلة المقالية
            if (!isMcq && question.studentAnswer != null)
              _buildAnswerSection(
                context,
                label: 'Your Answer:',
                content: question.studentAnswer!,
                color: question.isCorrect == true ? Colors.green : Colors.red,
              ),

            // الملاحظات إن وجدت
            if (question.explanation != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Feedback:",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        " ${question.explanation!}",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // تزيين الـ MCQ بنفس الشكل اللي استخدمته في الامتحان
  BoxDecoration _mcqDecoration({
    required bool isSelected,
    required bool isCorrect,
  }) {
    Color borderColor = const Color.fromARGB(255, 211, 210, 210);
    Color? bgColor;

    if (isCorrect && isSelected) {
      borderColor = Colors.green;
      bgColor = const Color(0xFF72EEA6).withOpacity(0.2);
    } else if (!isCorrect && isSelected) {
      borderColor = Colors.red;
      bgColor = Colors.red.withOpacity(0.1);
    }

    return BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(8),
      color: bgColor,
    );
  }

  Widget _buildAnswerSection(
    BuildContext context, {
    required String label,
    required String content,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
          Expanded(
            child: Text(content, style: TextStyle(fontSize: 15, color: color)),
          ),
        ],
      ),
    );
  }
}
