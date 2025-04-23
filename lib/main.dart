import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/widgets/layout_view.dart';
import 'package:light_quiz/features/auth/ui/views/login_view.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';
import 'package:light_quiz/features/groups/ui/managers/group_cubit.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';
import 'package:light_quiz/features/quiz/ui/cubits/quiz_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final pref = getIt.get<SharedPreferences>();
  runApp(StudentQuizApp(hasUser: pref.containsKey('token')));
}

class StudentQuizApp extends StatelessWidget {
  const StudentQuizApp({super.key, required this.hasUser});
  final bool hasUser;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuizCubit(getIt.get<QuizRepo>())),
        BlocProvider(
          create:
              (context) => GroupCubit(getIt.get<GroupRepo>())..getAllGroups(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'cairo',
          scaffoldBackgroundColor: AppColors.productColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: hasUser ? LayoutView() : LoginView(),
      ),
    );
  }
}
