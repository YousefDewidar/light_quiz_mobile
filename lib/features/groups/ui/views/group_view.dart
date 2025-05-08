import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';
import 'package:light_quiz/features/groups/ui/managers/group_state.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/group_card.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/join_group_dialog.dart';
import 'package:lottie/lottie.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GroupCubit>().getAllGroups();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return JoinGroupDialog();
            },
          );
        },
        child: Icon(Icons.group_add, color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: Theme.of(context).textTheme.bodyMedium!.color,
            width: double.infinity,
            child: Text(
              "Your Groups",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          BlocConsumer<GroupCubit, GroupState>(
            listener: (context, state) {
              if (state is JoinGroupFailure) {
                showNotification(context, state.errMessage, NotiType.error);
              }
              if (state is JoinGroupSuccess) {
                showNotification(
                  context,
                  "Joined Group Successfully",
                  NotiType.success,
                );
              }
              if (state is LeaveGroupSuccess) {
                showNotification(
                  context,
                  "Left Group Successfully",
                  NotiType.success,
                );
              }
            },
            builder: (context, state) {
              if (state is GroupLoading) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Lottie.asset('assets/ai_loading.json'),
                  ),
                );
              } else if (state is GroupSuccess) {
                
                final groups = state.groups;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final result = groups[index];
                      return GroupCard(group: result);
                    },
                  ),
                );
              } else if (state is GroupFail) {
                return Center(child: Text(state.errMessage));
              } else {
                return Center(child: Text("data"));
              }
            },
          ),
        ],
      ),
    );
  }
}
