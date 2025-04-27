import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/notifications/fcm_helper.dart';
import 'package:light_quiz/core/notifications/local_notification.dart';
import 'package:light_quiz/core/themes/theme_cubit.dart';
import 'package:light_quiz/core/themes/theme_data.dart';
import 'package:light_quiz/core/themes/theme_state.dart';
import 'package:light_quiz/core/widgets/layout_view.dart';
import 'package:light_quiz/features/auth/ui/views/login_view.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_cubit.dart';
import 'package:light_quiz/features/quiz/ui/cubits/response_cubit.dart';
import 'package:light_quiz/features/splash/ui/splash_view.dart';
import 'package:light_quiz/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  final hasUser = await getIt.get<FlutterSecureStorage>().containsKey(
    key: "token",
  );
  // getIt.get<SharedPreferences>().clear();
  FcmHelper().initNotification();
  LocalNotificationService.initNotification();
  runApp(StudentQuizApp(hasUser: hasUser));
}

class StudentQuizApp extends StatelessWidget {
  const StudentQuizApp({super.key, required this.hasUser});
  final bool hasUser;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..getTheme()),
        BlocProvider(create: (context) => QuizCubit(getIt.get<QuizRepo>())),
        BlocProvider(
          create:
              (context) => GroupCubit(getIt.get<GroupRepo>())..getAllGroups(),
        ),
        BlocProvider(create: (context) => ResponseCubit(getIt.get<QuizRepo>())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: state is ThemeChanged ? state.theme : null,
            // themeMode: ThemeMode.dark,
            theme: CustomThemeData.lightData(),
            darkTheme: CustomThemeData.darkData(),
            home:
                hasUser
                    ? SplashView(nextView: LayoutView())
                    : SplashView(nextView: LoginView()),
          );
        },
      ),
    );
  }
}
