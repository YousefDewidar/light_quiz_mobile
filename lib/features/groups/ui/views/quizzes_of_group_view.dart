import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';
import 'package:light_quiz/features/groups/ui/managers/group_state.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/quiz_group_card.dart';

class QuizzesOfGroupView extends StatelessWidget {
  const QuizzesOfGroupView({super.key, required this.group});
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GroupCubit(getIt.get<GroupRepo>())
                ..getQuizesOfGroup(shortCode: group.shortCode),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quizzes of ${group.name}",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
        ),
        body: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            if (state is GetQuizesOfGroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetQuizesOfGroupSuccess) {
              if (state.quizzes.isEmpty) {
                return Center(
                  child: Text(
                    'No quizzes found in this group',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = state.quizzes[index];
                  return QuizGroupCard(quiz: quiz);
                },
              );
            } else if (state is GetQuizesOfGroupFailure) {
              return Center(child: Text(state.errMessage));
            } else {
              return Center(
                child: Text(
                  'No quizzes found in this group',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
