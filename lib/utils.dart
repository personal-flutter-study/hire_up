import 'package:flutter/material.dart';

const Color blue = Color(0xff3366FF);
const Color grey = Color(0xff858585);
const String baseUri = 'http://10.0.2.2:8000';
final Map<String, String> baseHeader = {'Content-Type': 'application/json'};

extension QB on BuildContext {
  NavigatorState push(Widget page) =>
      Navigator.of(this)..push(MaterialPageRoute(builder: (context) => page));

  NavigatorState pop() => Navigator.of(this)..pop();
}

extension QT on TextStyle {
  TextStyle get b14 => copyWith(fontWeight: .bold, fontSize: 14);

  TextStyle get b16 => copyWith(fontWeight: .bold, fontSize: 16);

  TextStyle get b18 => copyWith(fontWeight: .bold, fontSize: 18);
  TextStyle get b20 => copyWith(fontWeight: .bold, fontSize: 20);

  TextStyle get b24 => copyWith(fontWeight: .bold, fontSize: 24);

  TextStyle get b38 => copyWith(fontWeight: .bold, fontSize: 38);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cg => copyWith(color: grey);

  TextStyle get cw => copyWith(color: Colors.white);
}

extension QS on String {
  Text text([TextStyle? style, TextAlign? align]) =>
      Text(this, style: style, textAlign: align);

  Image image([double? size]) => Image.asset(this, fit: .fitWidth, width: size);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
    BuildContext context,
  ) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: text(TextStyle())));
}

extension QN on num {
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

  SizedBox get sh => SizedBox(height: toDouble());

  SizedBox get sw => SizedBox(width: toDouble());
}

extension QI on IconData {
  Icon icon({double? size, Color? color}) =>
      Icon(this, size: size, color: color);
}
