import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/controllers/app_ctrl.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/screeens/sign_up_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key, this.onClose});

  final VoidCallback? onClose;

  Future<void> show(BuildContext context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => this,
  );

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool saveLogin = false;

  Future<bool> login({required String email, required String password}) async {
    final res = await post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      print('로그인 성공');
      prefs.setString(AppCtrl.tokenKey, body['data']['token']);
      appCtrl.user.value = UserModel.fromJson(body['data']['user']);
      return true;
    } else {
      (body['errors'] as List?)?.forEach(
        (element) => (element['message'] as String?)?.snack(context),
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530,
      child: BaseScaffold(
        child: 18.pa(
          Column(
            children: [
              Text('로그인', style: TextStyle().b24),

              8.sh,
              Text('HireUp에 오신 것을 환영합니다', style: TextStyle().b14.cg),

              38.sh,
              SearchField(
                h: '이메일을 입력해주세요',
                controller: email,
                color: Colors.white.withAlpha(200),
                p: Icons.email_outlined.icon(color: grey),
              ),
              18.sh,
              SearchField(
                h: '비밀번호를 입력해주세요',
                controller: password,
                hide: true,
                color: Colors.white.withAlpha(200),
                p: Icons.lock_outline.icon(color: grey),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: saveLogin,
                      onChanged: (value) {
                        setState(() {
                          saveLogin = !saveLogin;
                        });
                      },
                    ),

                    Text('로그인 상태 유지', style: TextStyle().b14.cg),

                    Spacer(),

                    TextButton(
                      style: ButtonStyle().min,
                      onPressed: () {
                        '비밀번호 찾기 서비스는 준비중에 있습니다.'.snack(context);
                      },
                      child: Text('비밀번호 찾기', style: TextStyle().b14.cb),
                    ),
                  ],
                ),
              ),

              Builder(
                builder: (context) {
                  return SizedBox(
                    width: .infinity,
                    child: AppButton.primary('로그인', () async {
                      final success = await login(
                        email: email.text,
                        password: password.text,
                      );

                      if (success) {
                        '로그인 성공'.snack(context);
                        context.back();
                      }
                    }),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Expanded(child: Divider(endIndent: 10, thickness: 2)),
                    Text('또는', style: TextStyle().b14.cg),
                    Expanded(child: Divider(indent: 10, thickness: 2)),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                spacing: 4,
                children: [
                  Text('계정이 없으신가요?', style: TextStyle().b16.cg),
                  TextButton(
                    onPressed: () {
                      context.go(SignUpScreen());
                    },
                    child: Text('회원가입', style: TextStyle().b16.cb),
                  ),
                ],
              ),

              12.sh,
            ],
          ),
        ),
      ),
    );
  }
}
