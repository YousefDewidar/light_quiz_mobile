import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';

class LeaveGroupDialog extends StatelessWidget {
  const LeaveGroupDialog({super.key, required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.redAccent.withOpacity(0.7)],
                ),
              ),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Leave Group",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Are you sure you want to leave this group?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    title: "Leave",
                    onPressed: () {
                      context.read<GroupCubit>().leaveGroup(
                        shortCode: group.shortCode,
                      );
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
