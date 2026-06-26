import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/home_screen.dart';
import 'package:hire_up_poc_3/screens/interview_choose_screen.dart';
import 'package:hire_up_poc_3/screens/profile_screen.dart';
import 'package:hire_up_poc_3/screens/resume_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final List<Widget> pages = [
    HomeScreen(),
    InterviewChooseScreen(),
    ResumeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appCtrl.page,
      builder: (context, value, child) {
        return BaseScaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: .fixed,
            selectedItemColor: blue,
            unselectedItemColor: grey,
            onTap: (value2) {
              appCtrl.page.value = value2;
            },
            backgroundColor: Colors.white,
            currentIndex: value,
            items: [
              BottomNavigationBarItem(
                icon: 12.ph(child: Icons.home.icon(size: 32)),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icons.mic.icon(size: 32),
                label: 'AI 면접',
              ),
              BottomNavigationBarItem(
                key: Key('하단 네비게이션의 "이력서" 탭 클릭'),
                icon: Icons.description_outlined.icon(size: 32),
                label: '이력서',
              ),
              BottomNavigationBarItem(
                icon: Icons.person_outline.icon(size: 32),
                label: '프로필',
              ),
            ],
          ),
          child: pages[value],
        );
      },
    );
  }
}
