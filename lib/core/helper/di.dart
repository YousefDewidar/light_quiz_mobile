import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:light_quiz/core/helper/api_service.dart';
import 'package:light_quiz/features/auth/domain/repo/auth_repo.dart';
import 'package:light_quiz/features/auth/domain/repo/auth_repo_impl.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo_impl.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<QuizRepo>(QuizRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<GroupRepo>(GroupRepoImpl(getIt.get<ApiService>()));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Secure Storage
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  getIt.registerSingleton<FlutterSecureStorage>(storage);
}
