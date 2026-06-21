import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/app_ctrl.dart';
import 'package:hire_up_poc_2/screens/base_screen.dart';
import 'package:hire_up_poc_2/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  appCtrl.loadBookmarkList();

  runApp(MaterialApp(home: BaseScreen()));
}

late final SharedPreferences prefs;
