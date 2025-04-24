import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';

class GroupMembersBottomSheet extends StatelessWidget {
  const GroupMembersBottomSheet({super.key, required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Members",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            shape: ContinuousRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            trailing: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.bodySmall!.color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Teacher',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                  ),
                ),
              ),
            ),
            leading: CircleAvatar(
              child: Image.network(group.teacher.avatarUrl),
            ),
            title: Text(group.teacher.name),
            subtitle: Text(group.teacher.email),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: group.members.length,
              itemBuilder: (context, index) {
                final member = group.members[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  title: Text(member.memberName),
                  subtitle: Text(member.memberEmail),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
