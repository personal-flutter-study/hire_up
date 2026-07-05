import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/main.dart';
import 'package:hire_up_poc_5/models/user_model.dart';
import 'package:hire_up_poc_5/screens/signup_screen.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:http/http.dart';

import '../app_ctrl.dart';

class LoginBottom extends StatefulWidget {
  const LoginBottom({super.key});

  show(context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => this,
  );

  @override
  State<LoginBottom> createState() => _LoginBottomState();
}

class _LoginBottomState extends State<LoginBottom> {
  final TextEditingController em = TextEditingController();
  final TextEditingController pw = TextEditingController();

  bool check = false;
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return 18.pa(
      child: Column(
        spacing: 12,
        mainAxisSize: .min,
        children: [
          '로그인'.text(TextStyle().b24),
          'HireUp에 오신 것을 환영합니다'.text(TextStyle().b14.cg),

          SizedBox(height: 12),

          1.pa(
            child: TextField(
              controller: em,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '이메일을 입력해주세요',
                prefixIcon: Icons.email_outlined.icon(),
                contentPadding: .symmetric(horizontal: 24, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
              ),
            ),
          ),

          1.pa(
            child: TextField(
              controller: pw,
              obscuringCharacter: '*',
              obscureText: hide,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '비밀번호를 입력해주세요',
                prefixIcon: Icons.lock_outline.icon(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                  style: IconButton.styleFrom(
                    tapTargetSize: .shrinkWrap,
                    padding: .zero,
                    minimumSize: .zero,
                  ),
                  icon: Icon(
                    hide ? Icons.visibility_off : Icons.visibility,
                    color: grey,
                  ),
                ),
                contentPadding: .symmetric(horizontal: 24, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(color: grey, width: 1.5),
                ),
              ),
            ),
          ),
          12.ph(
            child: Row(
              children: [
                Checkbox(
                  value: check,
                  onChanged: (value) async {
                    setState(() {
                      check = !check;
                    });
                  },
                ),
                '로그인 상태 유지'.text(TextStyle().cg),

                Spacer(),

                '비밀번호 찾기'.tButton(() {
                  '준비중에 있습니다.'.toast();
                }, tStyle: TextStyle().cb),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: .symmetric(vertical: 16),
              backgroundColor: blue,
              shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            ),
            onPressed: () async {
              if (await _login(context, em: em.text, pw: pw.text)) {
                if (check) {
                  print(await prefs.setString(keyToken, appCtrl.token));
                }
                '로그인 성공'.toast();
                context.back();
              }
            },
            child: Row(
              mainAxisAlignment: .center,
              children: ['로그인'.text(TextStyle().b16.cw)],
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: Divider()),
              12.pw(child: '또는'.text(TextStyle().cg)),
              Expanded(child: Divider()),
            ],
          ),

          18.ph(
            child: Row(
              mainAxisAlignment: .center,
              children: [
                '계정이 없으신가요?'.text(TextStyle().cg),
                '회원가입'.tButton(() {
                  context.back();
                  context.go(SignupScreen());
                }, tStyle: TextStyle().cb),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> _login(context, {required em, required pw}) async {
  try {
    final res = await post(
      Uri.parse('$baseUrl/auth/login'),
      headers: baseHeader,
      body: jsonEncode({"email": em, "password": pw}),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      appCtrl.token = body['data']['token'];
      appCtrl.user = UserModel.fromJson(body['data']['user']);

      appCtrl.change();
      return true;
    } else {
      body['errors']?.forEach((e) => (e['message'] as String?)?.toast());
    }
  } catch (e) {
    print(e);
  }

  return false;
}
