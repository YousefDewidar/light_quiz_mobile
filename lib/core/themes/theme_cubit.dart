import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/themes/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void changeTheme(context) {
    final pref = getIt.get<SharedPreferences>();

    if (Theme.of(context).brightness == Brightness.light) {
      pref.setInt("theme", 1);
      emit(ThemeChanged(ThemeMode.dark));
    } else if (Theme.of(context).brightness == Brightness.dark) {
      pref.setInt("theme", 2);
      emit(ThemeChanged(ThemeMode.light));
    }
  }

  void getTheme() {
    final pref = getIt.get<SharedPreferences>();
    if (pref.containsKey("theme")) {
      if (pref.getInt("theme") == 1) {
        emit(ThemeChanged(ThemeMode.dark));
      } else if (pref.getInt("theme") == 2) {
        emit(ThemeChanged(ThemeMode.light));
      }
    }
  }
}
