import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/data/models/quiz.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_state.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/blured_screen.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/question_card.dart';
import 'package:no_screenshot/no_screenshot.dart';

class QuizView extends StatefulWidget {
  final Quiz quiz;
  const QuizView({super.key, required this.quiz});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> with WidgetsBindingObserver {
  late Timer _timer;
  int _remainingSeconds = 0;
  late List<Answers> answers;
  bool _isBlurred = false;
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    disableScreenshot();
    answers =
        widget.quiz.questions
            .map((q) => Answers(questionId: q.questionId))
            .toList();

    _remainingSeconds = widget.quiz.durationMinutes * 60;
    _startTimer();
  }

  void disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  void enableScreenshot() async {
    await _noScreenshot.screenshotOn();
  }

  @override
  void dispose() {
    _timer.cancel();
    enableScreenshot();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      if (mounted) {
        setState(() {
          _isBlurred = true;
        });
      }
    } else if (state == AppLifecycleState.resumed) {
      if (mounted) {
        setState(() {
          _isBlurred = false;
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds == 0) {
        timer.cancel();
        _submitQuiz();
      } else {
        if (mounted) {
          setState(() => _remainingSeconds--);
        }
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _submitQuiz() async {
    await context.read<QuizCubit>().submitAnswers(
      submitQuizModel: SubmitQuizModel(
        quizId: widget.quiz.quizId,
        answers: answers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double percentage =
        1 - (_remainingSeconds / (widget.quiz.durationMinutes * 60));
    bool isWarning = percentage >= 0.7;

    return Scaffold(
      appBar: quizAppBar(percentage, isWarning, context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // List of questions
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.quiz.questions.length,
                    itemBuilder: (context, index) {
                      final question = widget.quiz.questions[index];
                      return QuestionCard(
                        answers: answers,
                        qIndex: index,
                        question: question,
                      );
                    },
                  ),
                ),

                BlocConsumer<QuizCubit, QuizState>(
                  listener: (context, state) async {
                    if (state is QuizSubmitSuccess) {
                      _timer.cancel();
                      showNotification(
                        context,
                        'Quiz submitted successfully 🎉\nCheck your result',
                        NotiType.success,
                      );
                      Navigator.pop(context);
                    } else if (state is QuizSubmitFailure) {
                      showNotification(context, state.message, NotiType.error);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: _submitQuiz,
                      isLoading: state is QuizSubmitLoading,
                      title: 'Submit',
                      icon:
                          state is QuizSubmitLoading
                              ? null
                              : Icon(Icons.send, color: Colors.white),
                    );
                  },
                ),
              ],
            ),
          ),

          if (_isBlurred) BluredScreen(),
        ],
      ),
    );
  }

  AppBar quizAppBar(double percentage, bool isWarning, BuildContext context) {
    return AppBar(
      title: Text(
        widget.quiz.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: LinearProgressIndicator(
          value: 1 - (_remainingSeconds / (widget.quiz.durationMinutes * 60)),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            percentage >= 0.7 ? Colors.redAccent : Colors.green,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isWarning ? Colors.redAccent : Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatTime(_remainingSeconds),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          exitQuizDialog(context);
        },
        icon: Transform.rotate(
          angle: 180 * 3.14 / 180,
          child: const Icon(Icons.logout_rounded),
        ),
      ),
    );
  }

  Future<dynamic> exitQuizDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Exit Quiz'),
            content: Text(
              'Are you sure you want to exit the quiz?',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Close quiz
                },
                child: const Text('Exit'),
              ),
            ],
          ),
    );
  }
}
