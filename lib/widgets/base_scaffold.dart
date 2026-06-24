import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.navigationBar,
    this.color,
    this.appBar,
  });

  final Widget child;
  final AppBar? appBar;
  final BottomNavigationBar? navigationBar;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: false,
        body: child,
        backgroundColor: color ?? Colors.white.withAlpha(240),
        bottomNavigationBar: navigationBar,
      ),
    );
  }
}
