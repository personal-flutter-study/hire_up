import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  appCtrl.token = prefs.getString(keyToken) ?? '';
  appCtrl.bookmarks =
      prefs.getStringList(keyBookmarks)?.map((e) => int.parse(e)).toList() ??
      [];

  SystemChrome.setPreferredOrientations([.portraitDown, .portraitUp]);

  runApp(MaterialApp(home: BaseScreen()));
}

MethodChannel channelM = MethodChannel('com.example.hire_up_poc_5_m');

late final SharedPreferences prefs;

const String keyToken = 'keyToken';
const String keyBookmarks = 'keyBookmarks';
