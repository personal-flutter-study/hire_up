import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.appBar,
    required this.child,
    this.bottomNavigationBar,
  });

  final AppBar? appBar;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        appBar: appBar,
        body: child,
      ),
    );
  }
}
