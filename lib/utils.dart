import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String baseUrl = 'http://10.0.2.2:3000';
const Map<String, String> baseHeader = {'Content-Type': 'application/json'};

const Color blue = Color(0xff3366FF);
const Color grey = Color(0xffCDCDCF);

enum Img {
  ai_interviewer('ai_interviewer.png'),
  app_icon('app_icon.png'),
  avatar_base('avatar_base.png'),
  logo_horizontal('logo_horizontal.png'),
  logo_vertical('logo_vertical.png'),
  lv0_mouth_closed('lv0_mouth_closed.png'),
  lv1_mouth_small('lv1_mouth_small.png'),
  lv2_mouth_medium('lv2_mouth_medium.png'),
  lv3_mouth_large('lv3_mouth_large.png');

  final String path;

  const Img(this.path);

  Image image({Color? color, double? size}) => Image.asset(
    'assets/images/$path',
    color: color,
    fit: .fitWidth,
    width: size,
  );
}

enum Category {
  who('HR', '전체'),
  dev('DEV', '개발'),
  des('DESIGN', '다자인'),
  mak('MARKETING', '마케팅');

  final String value;
  final String label;

  const Category(this.value, this.label);
}


enum Sort {
  latest('latest', '최신순'),
  popular('popular', '인기순'),
  salary('salary', '급여순');

  final String value;
  final String label;

  const Sort(this.value, this.label);
}

extension QB on ButtonStyle {
  ButtonStyle get min => copyWith(
    minimumSize: .all(.zero),
    padding: .all(.zero),
    tapTargetSize: .shrinkWrap,
  );
}

class AppButton {
  static ElevatedButton primaru(
    VoidCallback tap,
    String m, {
    Color? color,
    double? padding,
  }) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      backgroundColor: color ?? blue,
      padding: .symmetric(vertical: 12, horizontal: padding ?? 0),
    ),
    onPressed: tap,
    child: m.text(.new().b18.cw),
  );
}

extension QN on num {
  SizedBox get sw => SizedBox(width: toDouble());

  SizedBox get sh => SizedBox(height: toDouble());

  Padding pw({required Widget child}) => Padding(
    padding: .symmetric(horizontal: toDouble()),
    child: child,
  );

  Padding ph({required Widget child}) => Padding(
    padding: .symmetric(vertical: toDouble()),
    child: child,
  );

  Padding pa({required Widget child}) =>
      Padding(padding: .all(toDouble()), child: child);
}

extension QT on TextStyle {
  TextStyle get b14 => copyWith(fontWeight: .bold, fontSize: 14);

  TextStyle get b16 => copyWith(fontWeight: .bold, fontSize: 16);

  TextStyle get b18 => copyWith(fontWeight: .bold, fontSize: 18);

  TextStyle get b24 => copyWith(fontWeight: .bold, fontSize: 24);

  TextStyle get b38 => copyWith(fontWeight: .bold, fontSize: 38);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cg => copyWith(color: grey);

  TextStyle get cw => copyWith(color: Colors.white);
}

extension QS on String {
  Text text([TextStyle? style]) => Text(this, style: style);

  void snack(BuildContext context) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: text(.new().b16.cw), backgroundColor: blue));

  Image image({Color? color, double? size}) =>
      Image.asset(this, color: color, fit: .fitWidth, width: size);

  SvgPicture icon({Color? color, double? size}) =>
      SvgPicture.asset(this, color: color, fit: .fitWidth, width: size);
}

extension QC on BuildContext {
  NavigatorState go(Widget page) =>
      Navigator.of(this)..push(MaterialPageRoute(builder: (context) => page));

  NavigatorState back() => Navigator.of(this)..pop();
}

extension QI on IconData {
  Icon icon({Color? color, double size = 24}) =>
      Icon(this, color: color, size: size);
}
