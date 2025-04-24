import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/user_data.dart';
import 'package:light_quiz/core/themes/theme_cubit.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/main.dart';

class WelcomBar extends StatelessWidget {
  const WelcomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color.fromARGB(90, 223, 226, 226),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      'assets/logo_c.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 18),
              ),
              Text(
                '${getUserData()?.name} 👋',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton.filled(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.lightPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            onPressed: () {
              context.read<ThemeCubit>().changeTheme(context);
            },
            icon: Icon(Icons.notifications_none, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
