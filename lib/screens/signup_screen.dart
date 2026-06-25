import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_4/utils.dart';
import 'package:hire_up_poc_4/widgets/base_scaffold.dart';
import 'package:hire_up_poc_4/widgets/login_bottom_sheet.dart';
import 'package:http/http.dart';

import '../app_ctrl.dart';
import '../models/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController p1 = TextEditingController();
  final TextEditingController p2 = TextEditingController();
  final TextEditingController p3 = TextEditingController();

  bool hide = true;
  bool hide2 = true;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.back();
            LoginBottomSheet().show(context);
          },
          child: Icons.arrow_back_ios.icon(),
        ),
      ),
      child: 19.pw(
        child: SingleChildScrollView(
          child: Column(
            spacing: 18,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: .start,
                    children: [
                      'assets/images/logo_vertical.png'.image(size: 120),

                      '회원가입'.text(style: .new().b20),
                      'HireUp 계정을 만들어\n취업 준비를 시작해보세요!'.text(
                        style: .new().b16.cg,
                      ),
                    ],
                  ),

                  'assets/images/sign_up_main_img.png'.image(size: 160),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '이메일'.text(style: .new().b14.cg),
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
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '비밀번호'.text(style: .new().b14.cg),
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
                  '8자 이상, 대소문자, 숫자, 특수문자 포함'.text(
                    style: TextStyle(fontSize: 13, fontWeight: .bold).cg,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '비밀번호'.text(style: .new().b14.cg),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(12),
                      border: .all(color: grey),
                    ),
                    margin: .all(1),
                    child: TextField(
                      controller: password2,
                      obscureText: hide2,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        border: .none,
                        prefixIcon: Icons.lock_outline.icon(color: grey),
                        hintText: '비밀번호를 다시 입력해주세요',
                        contentPadding: .symmetric(vertical: 16),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide2 = !hide2;
                            });
                          },
                          icon: Icon(
                            hide2 ? Icons.visibility_off : Icons.visibility,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '이름'.text(style: .new().b14.cg),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(12),
                      border: .all(color: grey),
                    ),
                    margin: .all(1),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        border: .none,
                        prefixIcon: Icons.person_outline.icon(color: grey),
                        hintText: '이름을 입력해주세요',
                        contentPadding: .symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '휴대폰 번호'.text(style: .new().b14.cg),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: .circular(12),
                            border: .all(color: grey),
                          ),
                          margin: .all(1),
                          child: TextField(
                            controller: p1,
                            textAlign: .center,
                            decoration: InputDecoration(
                              border: .none,
                              hintText: '010',
                              contentPadding: .symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ),

                      32.sw(child: 12.pa(child: Divider())),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: .circular(12),
                            border: .all(color: grey),
                          ),
                          margin: .all(1),
                          child: TextField(
                            controller: p2,
                            textAlign: .center,
                            decoration: InputDecoration(
                              border: .none,
                              hintText: '0000',
                              contentPadding: .symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ),

                      32.sw(child: 12.pa(child: Divider())),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: .circular(12),
                            border: .all(color: grey),
                          ),
                          margin: .all(1),
                          child: TextField(
                            controller: p3,
                            textAlign: .center,
                            decoration: InputDecoration(
                              border: .none,
                              hintText: '0000',
                              contentPadding: .symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              1.pa(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(12),
                      side: BorderSide(color: blue),
                    ),
                    padding: .symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: .center,
                    children: ['인증번호 재발송'.text(style: .new().b16.cb)],
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  '인증번호'.text(style: .new().b14.cg),
                  Row(
                    spacing: 18,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: .circular(12),
                            border: .all(color: grey),
                          ),
                          margin: .all(1),
                          child: TextField(
                            decoration: InputDecoration(
                              border: .none,
                              prefixIcon: Icons.person_outline.icon(
                                color: grey,
                              ),
                              hintText: '인증번호 6자리',
                              contentPadding: .symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: blue.withAlpha(30),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(12),
                          ),
                          padding: .symmetric(vertical: 16),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: .center,
                          children: ['확인'.text(style: .new().b16.cb)],
                        ),
                      ),
                    ],
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
                  if (password2.text != password.text) {
                    '비밀번호 확인이 비밀번호와 일치하지 않습니다.'.snack(context);
                    return;
                  }

                  if (await _signup(
                    context,
                    email: email.text,
                    password: password.text,
                    name: name.text,
                    phone: '${p1.text}${p2.text}${p3.text}',
                  )) {
                    context.back();
                    LoginBottomSheet().show(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: .center,
                  children: ['회원가입'.text(style: .new().b16.cw)],
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  '이미 계정이 있으신가요?'.text(style: .new().b14.cg),
                  TextButton(
                    onPressed: () {
                      context.back();
                      LoginBottomSheet().show(context);
                    },
                    child: '로그인'.text(style: .new().b14.cb),
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

Future<bool> _signup(
  BuildContext context, {
  required String email,
  required String password,
  required String name,
  required String phone,
}) async {
  try {
    final res = await post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: baseHeader,
      body: jsonEncode({
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      }),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      appCtrl.user.value = UserModel.fromJson(body['data']['user']);
      '회원가입 성공'.snack(context);
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
