import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.navigationBar,
    this.color,
  });

  final Widget child;
  final BottomNavigationBar? navigationBar;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: child,
        backgroundColor: color ?? Colors.white,
        bottomNavigationBar: navigationBar,
      ),
    );
  }
}
