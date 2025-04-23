import 'package:flutter/material.dart';
import 'package:light_quiz/core/helper/user_data.dart';
import 'package:light_quiz/core/utils/app_colors.dart';

class WelcomBar extends StatelessWidget {
  const WelcomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset('assets/logo.png', width: 50, height: 50),
              );
            },
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                '${getUserData()?.name} 👋',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
