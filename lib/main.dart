import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_up_poc_1/screeens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(home: BaseScreen()));
}

const String baseUrl = 'http://10.0.2.2:3000';

const Color blue = Color(0xff3162F4);
const Color grey = Color(0xff959595);
const Color blueL = Color(0xffEEF2FE);

late final SharedPreferences prefs;
final platformM = MethodChannel('com.example.hire_up_poc_1_m');
