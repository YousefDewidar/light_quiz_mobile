import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/helper/user_data.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/features/auth/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            accountName: Text(
              getUserData()?.name ?? '',
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text(getUserData()?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: CachedNetworkImage(
                imageUrl: getUserData()!.avatarUrl,
                placeholder:
                    (context, url) =>
                        CircularProgressIndicator(color: Colors.orange),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              final pref = getIt.get<SharedPreferences>();
              pref.remove('token');
              pref.remove('user');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false,
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
