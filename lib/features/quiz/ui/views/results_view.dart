import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_state.dart';
import 'package:light_quiz/features/quiz/ui/cubits/response_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/response_state.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/result_card.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ResponseLoading,
          child: ResultViewBody());
      },
    );
  }
}

class ResultViewBody extends StatelessWidget {
  const ResultViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(getIt.get<QuizRepo>())..getResultsList(),
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizResultListLoading) {
            return Center(child: Lottie.asset('assets/ai_loading.json'));
          } else if (state is QuizResultListSuccess) {
            final results = state.resultsList;
            return Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  width: double.infinity,
                  child: Text(
                    "Your Results",
                    style: TextStyle(
                      fontSize: 19,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final result = results[index];
                      final isPassed =
                          result.grade >= result.possiblePoints / 2;
                      return ResultCard(isPassed: isPassed, result: result);
                    },
                  ),
                ),
              ],
            );
          } else if (state is QuizFail) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Lottie.asset('assets/ai_loading.json'));
          }
        },
      ),
    );
  }
}
