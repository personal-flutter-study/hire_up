import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/screens/home_screen.dart';
import 'package:hire_up_poc_5/screens/profile_screen.dart';
import 'package:hire_up_poc_5/screens/resume_screen.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appCtrl.page,
      builder: (context, page, child) {
        final pages = [
          HomeScreen(),
          SizedBox(),
          ResumeScreen(),
          ProfileScreen(),
        ];
        return BaseScaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: .fixed,
            backgroundColor: Colors.white,
            selectedItemColor: blue,
            unselectedItemColor: grey,
            iconSize: 38,
            currentIndex: page,
            onTap: (value) {
              setState(() {
                appCtrl.page.value = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icons.home.icon(), label: '홈'),
              BottomNavigationBarItem(icon: Icons.mic.icon(), label: 'AI 면접'),
              BottomNavigationBarItem(
                icon: Icons.description_outlined.icon(),
                label: '이력서',
              ),
              BottomNavigationBarItem(
                icon: Icons.person_outline.icon(),
                label: '프로필',
              ),
            ],
          ),
          child: pages[page],
        );
      },
    );
  }
}
