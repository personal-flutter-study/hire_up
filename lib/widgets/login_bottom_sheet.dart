import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/app_ctrl.dart';
import 'package:hire_up_poc_4/models/user_model.dart';
import 'package:hire_up_poc_4/screens/signup_screen.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:hire_up_poc_4/widgets/base_scaffold.dart';
import 'package:http/http.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  show(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) => this,
    showDragHandle: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxHeight: 550),
  );

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  bool hide = true;
  bool check = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: ColoredBox(
        color: Colors.white,
        child: 18.pw(
          child: Column(
            mainAxisAlignment: .spaceAround,
            children: [
              Column(
                spacing: 8,
                children: [
                  '로그인'.text(style: .new().b20),
                  'HireUp에 오신 것을 환영합니다'.text(style: .new().b14.cg),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(12),
                  border: .all(color: grey),
                ),
                margin: .all(1),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: .none,
                    prefixIcon: Icons.email_outlined.icon(color: grey),
                    hintText: '이메일을 입력해주세요',
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(12),
                  border: .all(color: grey),
                ),
                margin: .all(1),
                child: TextField(
                  controller: password,
                  obscureText: hide,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: .none,
                    prefixIcon: Icons.lock_outline.icon(color: grey),
                    hintText: '비밀번호를 입력해주세요',
                    contentPadding: .symmetric(vertical: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Icon(
                        hide ? Icons.visibility_off : Icons.visibility,
                        color: grey,
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    value: check,
                    onChanged: (value) {
                      setState(() {
                        check = !check;
                      });
                    },
                  ),

                  '로그인 상태 유지'.text(style: .new().b14.cg),

                  Spacer(),

                  TextButton(
                    onPressed: () {
                      '비밀번호 찾기 서비스는 준비중에 있습니다.'.snack(context);
                    },
                    child: '비밀번호 찾기'.text(style: .new().b14.cb),
                  ),
                ],
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  padding: .symmetric(vertical: 16),
                ),
                onPressed: () async {
                  if (await _login(
                    context,
                    email: email.text,
                    password: password.text,
                  )) {
                    context.back();
                    '로그인 성공'.snack(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: .center,
                  children: ['로그인'.text(style: .new().b16.cw)],
                ),
              ),

              Row(
                children: [
                  Expanded(child: Divider()),
                  18.pw(child: '또는'.text(style: .new().b14.cg)),
                  Expanded(child: Divider()),
                ],
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  '계정이 없으신가요?'.text(style: .new().b14.cg),
                  TextButton(
                    onPressed: () {
                      context.back();
                      context.go(SignupScreen());
                    },
                    child: '회원가입'.text(style: .new().b14.cb),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _login(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  try {
    final res = await post(
      Uri.parse('$baseUrl/auth/login'),
      headers: baseHeader,
      body: jsonEncode({"email": email, "password": password}),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      appCtrl.user.value = UserModel.fromJson(body['data']['user']);
      return true;
    } else {
      (body['errors'] as List).forEach(
        (e) => (e['message'] as String?)?.snack(context),
      );
    }
  } catch (e) {
    print(e);
  }

  return false;
}
