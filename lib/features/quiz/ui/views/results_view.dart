import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/managers/quiz_state.dart';
import 'package:light_quiz/features/quiz/ui/managers/response_cubit.dart';
import 'package:light_quiz/features/quiz/ui/managers/response_state.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/quiz_results_dispaly.dart';
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
          child: ResultViewBody(),
        );
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
            return QuizResultsDisplay(resultsList: state.resultsList);
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
