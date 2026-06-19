import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/screeens/ai_interview_choose_screen.dart';
import 'package:hire_up_poc_1/screeens/home_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';

import '../main.dart';
import '../widgets/utils.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> pages = [
    HomeScreen(),
    AiInterviewChooseScreen(),
    SizedBox(),
    SizedBox(),
  ];
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      navigationBar: BottomNavigationBar(
        type: .fixed,
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: blue,
        unselectedItemColor: grey,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icons.home.icon(color: page == 0 ? blue : grey),
          ),
          BottomNavigationBarItem(
            label: 'AI 면접',
            icon: Icons.mic.icon(color: page == 1 ? blue : grey),
          ),
          BottomNavigationBarItem(
            label: '이력서',
            icon: 'assets/icons/resume.svg'.icon(
              color: page == 2 ? blue : grey,
            ),
          ),
          BottomNavigationBarItem(
            label: '프로필',
            icon: Icons.person.icon(color: page == 3 ? blue : grey),
          ),
        ],
      ),
      child: pages[page],
    );
  }
}
