import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_quiz/features/quiz/ui/views/enter_exam_view.dart';
import 'package:light_quiz/features/groups/ui/views/group_view.dart';
import 'package:light_quiz/features/quiz/ui/views/results_view.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/custom_drawer.dart'
    show CustomDrawer;
import 'package:light_quiz/features/quiz/ui/views/widgets/welcome_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: SafeArea(child: WelcomBar()),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [EnterExamView(), GroupsView(), ResultsView()],
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: SizedBox(
          child: WaterDropNavBar(
            backgroundColor: Colors.transparent,
            waterDropColor: const Color.fromARGB(255, 12, 131, 62),
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
              pageController.animateToPage(
                selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad,
              );
            },
            selectedIndex: selectedIndex,
            barItems: [
              BarItem(
                filledIcon: Icons.home,
                outlinedIcon: Icons.home_outlined,
              ),
              BarItem(
                filledIcon: Icons.groups,
                outlinedIcon: Icons.groups_2_outlined,
              ),

              BarItem(
                filledIcon: Icons.insert_chart,
                outlinedIcon: Icons.insert_chart_outlined_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
