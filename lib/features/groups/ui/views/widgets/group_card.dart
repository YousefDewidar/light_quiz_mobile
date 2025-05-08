import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/ui/views/quizzes_of_group_view.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/group_members_bottom_sheet.dart';
import 'package:light_quiz/features/groups/ui/views/widgets/leave_group_dailog.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group});

  final GroupModel group;

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
                backgroundColor: Colors.green[100],
                child: Icon(
                  Icons.groups,
                  size: 30,
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      spacing: 5,
                      children: [
                        Icon(Icons.person),
                        Text(
                          "${group.members.length} members",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: Icon(Icons.logout, color: Colors.redAccent),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LeaveGroupDialog(group: group);
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            spacing: 15,
            children: [
              Expanded(
                child: CustomButton(
                  title: "View Members",
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return GroupMembersBottomSheet(group: group);
                      },
                    );
                  },
                  color: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: CustomButton(
                  title: "View Quizes",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizzesOfGroupView(group: group),
                      ),
                    );
                  },
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
