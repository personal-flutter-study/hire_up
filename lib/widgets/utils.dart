import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

enum ComImg {
  aws(" aws.png"),
  coupang("coupang.png"),
  flowtech("flowtech.png"),
  kakao("kakao.png"),
  karrot("karrot.png"),
  line("line.png"),
  musinsa("musinsa.png"),
  naver("naver.png"),
  protopie("protopie.png"),
  streamlab("streamlab.png"),
  toss("toss.png"),
  wanted("wanted.png"),
  woowa("woowa.png"),
  yanolja("yanolja.png"),
  zigbang("zigbang.png");

  final String p;

  const ComImg(this.p);

  Widget image({double size = 24}) =>
      Image.asset('assets/images/company/$p', fit: .fitWidth, width: size);
}

enum AppImg {
  ai_interviewer('ai_interviewer.png'),
  app_icon('app_icon.png'),
  avatar_base('avatar_base.png'),
  logo_horizontal('logo_horizontal.png'),
  logo_vertical('logo_vertical.png'),
  lv0_mouth_closed('lv0_mouth_closed.png'),
  lv1_mouth_small('lv1_mouth_small.png'),
  lv2_mouth_medium('lv2_mouth_medium.png'),
  lv3_mouth_large('lv3_mouth_large.png'),
  sign_up_main_img('sign_up_main_img.png');

  final String p;

  const AppImg(this.p);

  Widget image({double size = 24}) =>
      Image.asset('assets/images/$p', fit: .fitWidth, width: size);
}

enum CateGory {
  who(label: '전체', value: 'HR'),
  dev(label: '개발', value: 'DEV'),
  des(label: '디자인', value: 'DESIGN'),
  mct(label: '마케팅', value: 'MARKETING');

  final String label;
  final String value;

  const CateGory({required this.label, required this.value});
}

enum Sort {
  latest(label: '최신순', value: 'latest'),
  popular(label: '인기순', value: 'popular'),
  salary(label: '급여순', value: 'salary');

  final String label;
  final String value;

  const Sort({required this.label, required this.value});
}

extension QT on TextStyle {
  TextStyle get b24 => copyWith(fontWeight: .bold, fontSize: 24);

  TextStyle get b18 => copyWith(fontWeight: .bold, fontSize: 18);

  TextStyle get b14 => copyWith(fontWeight: .bold, fontSize: 14);

  TextStyle get b16 => copyWith(fontWeight: .bold, fontSize: 16);

  TextStyle get b38 => copyWith(fontWeight: .bold, fontSize: 38);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cg => copyWith(color: grey);
}

extension QB on ButtonStyle {
  ButtonStyle get min => copyWith(
    tapTargetSize: .shrinkWrap,
    minimumSize: .all(.zero),
    padding: .all(.zero),
  );
}

extension QC on BuildContext {
  NavigatorState go(Widget page) =>
      Navigator.of(this)..push(MaterialPageRoute(builder: (context) => page));

  NavigatorState back() => Navigator.of(this)..pop();
}

extension QS on String {
  void snack(context) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(this),
      backgroundColor: blue,
      duration: Duration(milliseconds: 600),
    ),
  );

  Widget text(TextStyle style) => Text(this);

  SvgPicture icon({Color? color, double? size}) =>
      SvgPicture.asset(this, color: color, fit: .fitWidth, width: size);

  Image image({Color? color, double? size}) =>
      Image.asset(this, color: color, fit: .fitWidth, width: size);
}

extension QN on num {
  SizedBox get sw => SizedBox(width: toDouble());

  SizedBox get sh => SizedBox(height: toDouble());

  Padding ph(Widget child) => Padding(
    padding: .symmetric(vertical: toDouble()),
    child: child,
  );

  Padding pw(Widget child) => Padding(
    padding: .symmetric(horizontal: toDouble()),
    child: child,
  );

  Padding pa(Widget child) => Padding(padding: .all(toDouble()), child: child);
}

extension QI on IconData {
  Icon icon({Color? color, double? size}) =>
      Icon(this, color: color, size: size);
}

class AppButton {
  AppButton._();

  static ElevatedButton outline(String m, VoidCallback tap) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(color: blue, width: 2),
      ),
      padding: .symmetric(vertical: 12),
    ),
    onPressed: tap,
    child: Text(m, style: TextStyle().b16.cb),
  );

  static ElevatedButton primary(
    String m,
    VoidCallback tap, {
    double? padding,
  }) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      backgroundColor: blue,
      padding: .symmetric(vertical: 12, horizontal: padding ?? 0),
    ),
    onPressed: tap,
    child: Text(m, style: TextStyle(color: Colors.white).b16),
  );
}
