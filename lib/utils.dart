import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/main.dart';

const Color blue = Color(0xff3366FF);
const Color grey = Color(0xffBBBBBB);
const String baseUrl = 'http://10.53.68.33';

Map<String, String> get baseHeader => {'Content-Type': 'application/json'};

Map<String, String> get authHeader => {'Authorization': 'Bearer ${appCtrl.token}'};

extension QS on String {
  Text text([TextStyle? style, TextAlign? align]) =>
      Text(this, style: style, textAlign: align);

  tButton(
    VoidCallback tap, {
    ButtonStyle? style,
    TextStyle? tStyle,
    TextAlign? align,
  }) => TextButton(
    style:
        style ??
        TextButton.styleFrom(
          tapTargetSize: .shrinkWrap,
          padding: .zero,
          minimumSize: .zero,
        ),
    onPressed: tap,
    child: text(tStyle, align),
  );

  Image image([double? size]) => Image.asset(this, fit: .fitWidth, width: size);

  Future<dynamic> toast() => channelM.invokeMethod('t', {'t': this});
}

extension Qn on num {
  Padding pa({required Widget child}) =>
      Padding(padding: .all(toDouble()), child: child);

  Padding pw({required Widget child}) => Padding(
    padding: .symmetric(horizontal: toDouble()),
    child: child,
  );

  Padding ph({required Widget child}) => Padding(
    padding: .symmetric(vertical: toDouble()),
    child: child,
  );
}

extension QC on BuildContext {
  Future<dynamic> go(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => page));

  void back() => Navigator.pop(this);
}

extension QT on TextStyle {
  TextStyle get b => copyWith(fontWeight: .bold);

  TextStyle get b14 => copyWith(fontWeight: .bold, fontSize: 14);

  TextStyle get b16 => copyWith(fontWeight: .bold, fontSize: 16);

  TextStyle get b18 => copyWith(fontWeight: .bold, fontSize: 18);

  TextStyle get b20 => copyWith(fontWeight: .bold, fontSize: 20);

  TextStyle get b24 => copyWith(fontWeight: .bold, fontSize: 24);

  TextStyle get b28 => copyWith(fontWeight: .bold, fontSize: 28);

  TextStyle get b32 => copyWith(fontWeight: .bold, fontSize: 32);

  TextStyle get cg => copyWith(color: grey);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cw => copyWith(color: Colors.white);
}

extension Qi on IconData {
  Icon icon({Color? color, double? size}) =>
      Icon(this, size: size, color: color);

  IconButton iButton(
    VoidCallback tap, {
    ButtonStyle? style,
    Color? color,
    double? size,
  }) => IconButton(
    style:
        style ??
        IconButton.styleFrom(
          tapTargetSize: .shrinkWrap,
          padding: .zero,
          minimumSize: .zero,
        ),
    onPressed: tap,
    icon: icon(color: color, size: size),
  );
}
