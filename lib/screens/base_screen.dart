import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/screens/home_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> pages = [HomeScreen(), SizedBox(), SizedBox(), SizedBox()];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        selectedItemColor: blue,
        unselectedItemColor: grey,
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icons.home.icon(size: 32), label: '홈'),
          BottomNavigationBarItem(
            icon: Icons.mic.icon(size: 32),
            label: 'AI 면접',
          ),
          BottomNavigationBarItem(
            icon: Icons.description_outlined.icon(size: 32),
            label: '이력서',
          ),
          BottomNavigationBarItem(
            icon: Icons.person_outline.icon(size: 32),
            label: '프로필',
          ),
        ],
      ),
      child: pages[page],
    );
  }
}
