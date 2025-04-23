import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/features/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserModel? getUserData() {
  final pref = getIt.get<SharedPreferences>();

  String? userString = pref.getString('user');

  if (userString != null) {
    return UserModel.fromJson(userString);
  }
  return null;
}
