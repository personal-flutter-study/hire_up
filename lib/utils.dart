import 'package:flutter/material.dart';

const Color blue = Color(0xff3366FF);
const Color grey = Color(0xffBBBBBB);
const String baseUrl = 'http://10.0.2.2:8000';
const Map<String, String> baseHeader = {'Content-Type': 'application/json'};

extension QB on BuildContext {
  go(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));

  back() => Navigator.of(this).pop();
}

extension QS on String {
  Image image({double? size}) => Image.asset(this, fit: .fitWidth, width: size);

  Text text({TextStyle? style, TextAlign? align}) =>
      Text(this, style: style, textAlign: align);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
    BuildContext context,
  ) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text()));
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

  SizedBox sh({Widget? child}) => SizedBox(height: toDouble(), child: child);

  SizedBox sw({Widget? child}) => SizedBox(width: toDouble(), child: child);
}

extension QT on TextStyle {
  TextStyle get b14 => copyWith(fontSize: 14, fontWeight: .bold);

  TextStyle get b16 => copyWith(fontSize: 16, fontWeight: .bold);

  TextStyle get b18 => copyWith(fontSize: 18, fontWeight: .bold);

  TextStyle get b20 => copyWith(fontSize: 20, fontWeight: .bold);

  TextStyle get b24 => copyWith(fontSize: 24, fontWeight: .bold);

  TextStyle get b28 => copyWith(fontSize: 28, fontWeight: .bold);

  TextStyle get b32 => copyWith(fontSize: 32, fontWeight: .bold);

  TextStyle get cg => copyWith(color: grey);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cw => copyWith(color: Colors.white);
}

extension QI on IconData {
  Icon icon({double? size, Color? color}) =>
      Icon(this, color: color, size: size);
}
