import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/login_bottom.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController em = TextEditingController();
  final TextEditingController pw = TextEditingController();
  final TextEditingController pw2 = TextEditingController();
  final TextEditingController na = TextEditingController();
  final TextEditingController p1 = TextEditingController();
  final TextEditingController p2 = TextEditingController();
  final TextEditingController p3 = TextEditingController();
  final TextEditingController code = TextEditingController();

  bool hide = true;
  bool hide2 = true;

  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: Icons.arrow_back_ios.iButton(() {
          context.back();
          LoginBottom().show(context);
        }),
      ),
      child: SingleChildScrollView(
        child: 18.pa(
          child: Column(
            spacing: 22,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: .start,
                      children: [
                        'assets/images/logo_vertical.png'.image(120),

                        '회원가입'.text(TextStyle().b24),

                        'HireUp 계정을 만들어\n취업 준비를 시작해보세요!'.text(
                          TextStyle().b16.cg,
                        ),
                      ],
                    ),
                  ),

                  'assets/images/sign_up_main_img.png'.image(160),
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  '이메일'.text(TextStyle().cg.b14),

                  1.pa(
                    child: TextField(
                      controller: em,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '이메일을 입력해주세요',
                        prefixIcon: Icons.email_outlined.icon(),
                        contentPadding: .symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
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
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  '비밀번호'.text(TextStyle().cg.b14),

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
                        contentPadding: .symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
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
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  '비밀번호 확인'.text(TextStyle().cg.b14),

                  1.pa(
                    child: TextField(
                      controller: pw2,
                      obscuringCharacter: '*',
                      obscureText: hide2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '비밀번호를 다시 입력해주세요',
                        prefixIcon: Icons.lock_outline.icon(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide2 = !hide2;
                            });
                          },
                          style: IconButton.styleFrom(
                            tapTargetSize: .shrinkWrap,
                            padding: .zero,
                            minimumSize: .zero,
                          ),
                          icon: Icon(
                            hide2 ? Icons.visibility_off : Icons.visibility,
                            color: grey,
                          ),
                        ),
                        contentPadding: .symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
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
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  '이름'.text(TextStyle().cg.b14),

                  1.pa(
                    child: TextField(
                      controller: na,

                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z가-힣]*'),
                        ),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '이름을 입력해주세요',
                        prefixIcon: Icons.person_outline.icon(),
                        contentPadding: .symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
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
                ],
              ),

              Column(
                crossAxisAlignment: .start,
                children: [
                  '휴대폰 번호'.text(TextStyle().cg.b14),

                  Row(
                    children: [
                      Expanded(
                        child: 1.pa(
                          child: TextField(
                            textAlign: .center,
                            controller: p1,
                            maxLength: 3,

                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'\d')),
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '010',
                              contentPadding: .symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
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
                      ),

                      SizedBox(
                        width: 24,
                        child: 8.pw(child: Divider(thickness: 2)),
                      ),
                      Expanded(
                        child: 1.pa(
                          child: TextField(
                            textAlign: .center,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'\d')),
                            ],
                            controller: p2,
                            maxLength: 4,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '0000',
                              contentPadding: .symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
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
                      ),

                      SizedBox(
                        width: 24,
                        child: 8.pw(child: Divider(thickness: 2)),
                      ),

                      Expanded(
                        child: 1.pa(
                          child: TextField(
                            textAlign: .center,

                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'\d')),
                            ],
                            controller: p3,
                            maxLength: 4,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '0000',
                              contentPadding: .symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
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
                      ),
                    ],
                  ),
                ],
              ),

              if (confirm)
                Row(
                  children: [
                    if (confirm)
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: .symmetric(vertical: 16),
                            backgroundColor: .lerp(
                              Colors.green,
                              Colors.white,
                              .8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: .circular(12),
                              side: BorderSide(color: Colors.green, width: 2),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: .center,
                            spacing: 12,
                            children: [
                              Icons.check_circle.icon(color: Colors.green),
                              '인증완료'.text(TextStyle(color: Colors.green).b16),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

              if (!confirm)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: .symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(12),
                      side: BorderSide(color: blue, width: 2),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      print("${p1.text}${p2.text}${p3.text}");

                      final res = await post(
                        Uri.parse('$baseUrl/auth/phone/send'),
                        headers: baseHeader,
                        body: jsonEncode({
                          "phone": "${p1.text}${p2.text}${p3.text}",
                        }),
                      );

                      final body = jsonDecode(res.body);

                      if (res.statusCode == 200) {
                        '발송 성공'.toast();
                      } else {
                        body['errors']?.forEach(
                          (e) => (e['message'] as String?)?.toast(),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: ['인증번호 발송'.text(TextStyle().b16.cb)],
                  ),
                ),

              if (!confirm)
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    '인증 번호'.text(TextStyle().cg.b14),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: code,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '인증번호 6자리',
                              contentPadding: .symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
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

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: .symmetric(vertical: 16),
                            backgroundColor: .lerp(blue, Colors.white, .9),
                            shape: RoundedRectangleBorder(
                              borderRadius: .circular(12),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final res = await post(
                                Uri.parse('$baseUrl/auth/phone/verify'),
                                headers: baseHeader,
                                body: jsonEncode({
                                  "phone": "${p1.text}${p2.text}${p3.text}",
                                  "code": code.text,
                                }),
                              );

                              final body = jsonDecode(res.body);

                              if (res.statusCode == 200) {
                                '인증 성공'.toast();
                                setState(() {
                                  confirm = true;
                                });
                              } else {
                                body['errors']?.forEach(
                                  (e) => (e['message'] as String?)?.toast(),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: .center,
                            children: ['확인'.text(TextStyle().b16.cb)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              12.ph(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: .symmetric(vertical: 16),
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  ),
                  onPressed: () async {
                    if (pw.text != pw2.text) {
                      '비밀번호 확인과, 비밀번호가 일치하지 않습니다.'.toast();
                      return;
                    }

                    if (await _signup(
                      context,
                      em: em.text,
                      pw: pw.text,
                      na: na.text,
                      ph: '${p1.text}${p2.text}${p3.text}',
                    )) {
                      '회원 가입 성공'.toast();
                      context.back();
                      LoginBottom().show(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: ['회원가입'.text(TextStyle().b16.cw)],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  '이미 계정이 있으신가요?'.text(TextStyle().cg),
                  '로그인'.tButton(() {
                    context.back();
                    LoginBottom().show(context);
                  }, tStyle: TextStyle().cb),
                ],
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _signup(
  context, {
  required em,
  required pw,
  required na,
  required ph,
}) async {
  try {
    final res = await post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: baseHeader,
      body: jsonEncode({"email": em, "password": pw, "name": na, "phone": ph}),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
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
