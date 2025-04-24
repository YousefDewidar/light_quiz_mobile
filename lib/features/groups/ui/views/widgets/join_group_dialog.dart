import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/custom_button.dart';
import 'package:light_quiz/core/widgets/custom_text_field.dart';
import 'package:light_quiz/core/widgets/in_app_notification.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';

class JoinGroupDialog extends StatelessWidget {
  const JoinGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController groupCon = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
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
                  colors: [
                    AppColors.primaryColor,
                    AppColors.lightPrimaryColor.withOpacity(0.7),
                  ],
                ),
              ),
              child: const Icon(
                Icons.group_add_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              "Join New Group",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
            ),

            const SizedBox(height: 24),

            CustomTextField(
              hint: "Enter Group Code",
              controller: groupCon,
              preIcon: Icon(Icons.link_rounded),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: CustomButton(
                    title: "Join",
                    onPressed: () async {
                      if (groupCon.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        context.read<GroupCubit>().joinGroup(
                          shortCode: groupCon.text,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      } else {
                        showNotification(
                          context,
                          "Please enter group code",
                          NotiType.warning,
                        );
                      }
                    },

                    // isLoading: state is QuizLoading,
                    color: AppColors.lightPrimaryColor,
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
