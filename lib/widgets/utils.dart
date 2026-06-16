import 'package:flutter/cupertino.dart';
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

enum AppIcon {
  back('back.svg'),
  bookmark('bookmark.svg'),
  check('check.svg'),
  chevron('chevron-right.svg'),
  delete('delete.svg'),
  edit('edit.svg'),
  email('email.svg'),
  filter('filter.svg'),
  heart('heart.svg'),
  home('home.svg'),
  interview('interview.svg'),
  lock('lock.svg'),
  mic('mic.svg'),
  notification('notification.svg'),
  person('person.svg'),
  profile('profile.svg'),
  resume('resume.svg'),
  search('search.svg'),
  share('share.svg'),
  sound('sound-wave.svg'),
  stop('stop.svg'),
  visibility('visibility.svg'),
  visibilityOff('visibility-off.svg');

  final String p;

  const AppIcon(this.p);

  Widget icon({double size = 24, Color? color}) => SvgPicture.asset(
    'assets/icons/$p',
    fit: .fitWidth,
    width: size,
    color: color,
  );
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

extension QT on TextStyle {
  TextStyle get b24 => copyWith(fontWeight: .bold, fontSize: 24);

  TextStyle get b18 => copyWith(fontWeight: .bold, fontSize: 18);

  TextStyle get b14 => copyWith(fontWeight: .bold, fontSize: 14);

  TextStyle get b16 => copyWith(fontWeight: .bold, fontSize: 16);

  TextStyle get b38 => copyWith(fontWeight: .bold, fontSize: 38);

  TextStyle get cb => copyWith(color: blue);

  TextStyle get cg => copyWith(color: tGrey);
}

extension QN on Navigator {
  NavigatorState go(BuildContext context, Widget page) =>
      Navigator.of(context)
        ..push(MaterialPageRoute(builder: (context) => page));
}

extension QS on String {
  void snack(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(this)));
}
