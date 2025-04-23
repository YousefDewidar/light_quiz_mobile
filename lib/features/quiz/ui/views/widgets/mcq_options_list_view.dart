import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/quiz/data/models/option.dart';
import 'package:light_quiz/features/quiz/data/models/question.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';

class McqOptionsListView extends StatefulWidget {
  const McqOptionsListView({
    super.key,
    required this.question,
    required this.answers,
    required this.qIndex,
  });
  final Questions question;
  final List<Answers> answers;
  final int qIndex;

  @override
  State<McqOptionsListView> createState() => _McqOptionsListViewState();
}

class _McqOptionsListViewState extends State<McqOptionsListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.qIndex >= widget.answers.length) {
      return const SizedBox(); // حماية من الوصول الخاطئ
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.question.options!.length,
      itemBuilder: (context, index) {
        final opt = widget.question.options![index];
        final selectedOption = widget.answers[widget.qIndex].optionLetter;

        return Container(
          decoration: decorOfmcqCard(widget.question, opt),
          margin: const EdgeInsets.only(bottom: 5),
          child: RadioListTile<String>(
            title: Text(opt.optionText),
            value: opt.optionLetter,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                widget.answers[widget.qIndex].optionLetter = value!;
              });
            },
          ),
        );
      },
    );
  }

  BoxDecoration decorOfmcqCard(Questions question, Option opt) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border:
          widget.answers[widget.qIndex].optionLetter == opt.optionLetter
              ? Border.all(color: AppColors.lightPrimaryColor)
              : Border.all(color: const Color.fromARGB(255, 211, 210, 210)),
      color:
          widget.answers[widget.qIndex].optionLetter == opt.optionLetter
              ? const Color(0xFF72EEA6).withOpacity(0.2)
              : Colors.transparent,
    );
  }
}
