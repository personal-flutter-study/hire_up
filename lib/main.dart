import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  await appCtrl.init();

  runApp(MaterialApp(home: BaseScreen()));
}

late final SharedPreferences prefs;
