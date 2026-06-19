import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';
import 'package:http/http.dart';

import '../main.dart';
import '../widgets/utils.dart';

final _controller = _SignUpController();

class _SignUpController {
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();
  final TextEditingController phone3 = TextEditingController();

  final ValueNotifier<String> code = ValueNotifier('');

  final ValueNotifier<bool> verified = ValueNotifier(false);

  Timer? timer;

  String get phone =>
      '${phone1.text.trim()}${phone2.text.trim()}${phone3.text.trim()}';

  Timer _timer(int exp, BuildContext context) =>
      Timer.periodic(Duration(seconds: 1), (timer) async {
        platformM.invokeMethod('permission').then((value) {
          if (value) {
            platformM.invokeMethod('sms').then((value) {
              if (value != null) {
                '문자 코드 수신 완료'.snack(context);
                code.value = RegExp(r'\d+').stringMatch(value) ?? '';
                timer.cancel();
              }
            });
          } else {
            '문자 수신 권한을 허용해 주세요'.snack(context);
            timer.cancel();
          }
        });

        if (timer.tick == exp) {
          '인증코드가 만료되었습니다. 다시 발송해 주세요.'.snack(context);
          timer.cancel();
        }
      });

  Future<bool> send(BuildContext context) async {
    final res = await post(
      Uri.parse('$baseUrl/auth/phone/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"phone": phone}),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      timer = _timer(body['data']['expiresIn'], context);
      '인증번호 발송 성공'.snack(context);
      return true;
    } else {
      (body['errors'] as List?)?.forEach(
        (element) => (element['message'] as String?)?.snack(context),
      );
    }

    return false;
  }

  Future<bool> verify(BuildContext context, String code) async {
    final res = await post(
      Uri.parse('$baseUrl/auth/phone/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"phone": phone, "code": code}),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      '인증번호 확인 성공'.snack(context);
      verified.value = body['data']['verified'];
      return true;
    } else {
      (body['errors'] as List?)?.forEach(
        (element) => (element['message'] as String?)?.snack(context),
      );
    }

    return false;
  }

  Future<bool> signUp(
    BuildContext context, {
    required String email,
    required (String p1, String p2) password,
    required String name,
  }) async {
    if (!verified.value) {
      '휴대전화 인증이 필요합니다.'.snack(context);
      return false;
    }

    if (password.$1 != password.$2) {
      '비밀번호 확인은 비밀번호와 일치해야 합니다.'.snack(context);
      return false;
    }

    final res = await post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email.trim(),
        "password": password.$1.trim(),
        "name": name.trim(),
        "phone": phone,
      }),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 201) {
      print('회원가입 성공');
      return true;
    } else {
      (body['errors'] as List?)?.forEach(
        (element) => (element['message'] as String?)?.snack(context),
      );
    }

    return false;
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        Column(
          crossAxisAlignment: .start,
          children: [
            IconButton(
              onPressed: () {
                context.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),

            22.sh,

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            AppImg.logo_vertical.image(size: 100),

                            12.ph(Text('회원가입', style: TextStyle().b24)),
                            Text(
                              'HireUp 계정을 만들어\n취업 준비를 시작해보세요!',
                              style: TextStyle().b14.cg,
                            ),
                          ],
                        ),

                        32.sw,
                        AppImg.sign_up_main_img.image(size: 120),
                      ],
                    ),

                    12.ph(
                      SearchField(
                        controller: email,
                        label: '이메일',
                        h: '이메일을 입력해주세요',
                        p: Icons.email_outlined.icon(),
                      ),
                    ),
                    12.ph(
                      SearchField(
                        controller: password,
                        label: '비밀번호',
                        h: '비밀번호를 입력해주세요',
                        p: Icons.lock_outline.icon(),
                        hide: true,
                        tip: '8자 이상, 대소문자, 숫자, 특수문자 포함',
                      ),
                    ),
                    12.ph(
                      SearchField(
                        controller: password2,
                        label: '비밀번호 확인',
                        h: '비밀번호를 다시 입력해주세요',
                        p: Icons.lock_outline.icon(),
                        hide: true,
                      ),
                    ),
                    12.ph(
                      SearchField(
                        controller: name,
                        label: '이름',
                        h: '이름을 입력해주세요',
                        formatter: .allow(RegExp(r'[A-Za-z가-힣]')),
                        p: Icons.person_outline.icon(),
                      ),
                    ),

                    _Email(),

                    24.sh,

                    SizedBox(
                      width: .infinity,
                      child: AppButton.primary('회원가입', () async {
                        final success = await _controller.signUp(
                          context,
                          email: email.text,
                          password: (password.text, password2.text),
                          name: name.text,
                        );

                        print(success);

                        if (success) {
                          '회원 가입 성공'.snack(context);
                          context.back();
                        }
                      }),
                    ),

                    14.sh,

                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text('이미 계정이 있으신가요?', style: TextStyle().b14.cg),
                        TextButton(
                          onPressed: () {
                            context.back();
                          },
                          child: Text('로그인', style: TextStyle().b14.cb),
                        ),
                      ],
                    ),

                    28.sh,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Email extends StatefulWidget {
  @override
  State<_Email> createState() => _EmailState();
}

class _EmailState extends State<_Email> {
  final TextEditingController code = TextEditingController();

  @override
  void initState() {
    _controller.code.addListener(() {
      code.text = _controller.code.value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 12.ph(
      Column(
        crossAxisAlignment: .start,
        children: [
          Text('휴대폰 번호', style: TextStyle().b14.cg),

          8.sh,

          Row(
            children: [
              Expanded(
                child: SearchField(
                  controller: _controller.phone1,
                  h: '010',
                  alignment: .center,
                  length: 3,
                  formatter: .allow(RegExp(r'\d')),
                ),
              ),
              SizedBox(
                width: 24,
                child: Divider(thickness: 2, endIndent: 8, indent: 8),
              ),
              Expanded(
                child: SearchField(
                  controller: _controller.phone2,
                  h: '0000',
                  alignment: .center,
                  length: 4,
                  formatter: .allow(RegExp(r'\d')),
                ),
              ),
              SizedBox(
                width: 24,
                child: Divider(thickness: 2, endIndent: 8, indent: 8),
              ),
              Expanded(
                child: SearchField(
                  h: '0000',
                  controller: _controller.phone3,
                  formatter: .allow(RegExp(r'\d')),
                  alignment: .center,
                  length: 4,
                ),
              ),
            ],
          ),

          12.sh,

          ValueListenableBuilder(
            valueListenable: _controller.verified,
            builder: (context, value, child) {
              return Column(
                children: [
                  12.ph(
                    SizedBox(
                      width: .maxFinite,
                      child: value
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(12),
                                  side: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                                padding: .symmetric(vertical: 12),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  Text(
                                    '인증완료',
                                    style: TextStyle(color: Colors.green).b16,
                                  ),
                                ],
                              ),
                            )
                          : AppButton.outline('인증번호 재발송', () {
                              _controller.send(context);
                            }),
                    ),
                  ),

                  if (!value) ...{
                    Row(
                      crossAxisAlignment: .end,
                      children: [
                        Expanded(
                          child: SearchField(
                            padding: .symmetric(horizontal: 18),
                            controller: code,
                            label: '인증번호',
                            h: '인증번호 6자리',
                          ),
                        ),

                        14.pw(
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blueL,
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                              padding: .symmetric(vertical: 12, horizontal: 12),
                            ),
                            onPressed: () {
                              _controller.verify(context, code.text);
                            },
                            child: Text('확인', style: TextStyle().b16.cb),
                          ),
                        ),
                      ],
                    ),
                  },
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
