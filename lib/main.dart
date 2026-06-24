import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  appCtrl.loadBookmarks();
  appCtrl.loadTags();

  runApp(MaterialApp(home: BaseScreen()));
}

late final SharedPreferences prefs;

final MethodChannel platformM = MethodChannel('com.example.hire_up_poc_3_m');
