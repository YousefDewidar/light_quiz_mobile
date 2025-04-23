import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
              backgroundColor: Colors.white,
              child: Text(
                getUserData()?.name[0].toUpperCase() ?? 'U',
                style: TextStyle(fontSize: 24, color: AppColors.primaryColor),
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
            onTap: () async {
              final secure = getIt.get<FlutterSecureStorage>();
              final pref = getIt.get<SharedPreferences>();
              await secure.delete(key: 'token');
              pref.remove('user');
              // ignore: use_build_context_synchronously
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
