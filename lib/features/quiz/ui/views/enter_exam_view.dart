import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_state.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/core/widgets/custom_text_field.dart';
import 'package:light_quiz/features/quiz/ui/views/quiz_view.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/quiz_result_dialog.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/start_quiz_dialog.dart';
import 'package:lottie/lottie.dart';

class EnterExamView extends StatefulWidget {
  const EnterExamView({super.key});

  @override
  State<EnterExamView> createState() => _EnterExamViewState();
}

class _EnterExamViewState extends State<EnterExamView> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _submitCode() {
    final code = _controller.text.trim();
    if (code.isNotEmpty) {
      context.read<QuizCubit>().getMetaData(shortCode: code);
    } else {
      showNotification(context, 'Please Enter exam code', NotiType.warning);
    }
  }

  Future<void> _viewResultByCode() async {
    final code = _controller.text.trim();
    if (code.isNotEmpty) {
      await context.read<QuizCubit>().getResult(shortCode: code);
    } else {
      showNotification(context, 'Please Enter exam code', NotiType.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is QuizMetaDataSuccess) {
          showDialog(
            context: context,
            builder: (ctx) {
              return StartQuizDialog(metaData: state.metaData, state: state);
            },
          );
        } else if (state is QuizFail) {
          showNotification(context, state.message, NotiType.error);
        } else if (state is QuizSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizView(quiz: state.quiz)),
          );
        }
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 35),

                Text(
                  'Let\'s test your knowledge today! 🎓\nExam grading powered by AI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Lottie.asset(
                    "assets/exam_animation.json",
                    height: 260,
                  ),
                ),

                const SizedBox(height: 30),

                // TextField
                CustomTextField(
                  controller: _controller,
                  hint: 'Enter Exam Code',
                  preIcon: Icon(Icons.link_rounded),
                ),

                const SizedBox(height: 20),

                // Start Quiz Button
                BlocBuilder<QuizCubit, QuizState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed:
                          state is QuizMetaDataLoading ? null : _submitCode,
                      title: 'Join Quiz',
                      isLoading: state is QuizMetaDataLoading,
                    );
                  },
                ),
                const SizedBox(height: 10),
                BlocConsumer<QuizCubit, QuizState>(
                  listener: (context, state) {
                    if (state is QuizResultSuccess) {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return QuizResultDialog(
                            result: state.result,
                            shortCode: _controller.text,
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onPressed:
                          state is QuizResultLoading ? null : _viewResultByCode,
                      title: 'View Results',
                      color: Colors.orangeAccent,
                      icon:
                          state is QuizResultLoading
                              ? null
                              : Icon(
                                Icons.bar_chart_rounded,
                                color: Colors.white,
                              ),
                      isLoading: state is QuizResultLoading,
                    );
                  },
                ),
                // View Results Button
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
