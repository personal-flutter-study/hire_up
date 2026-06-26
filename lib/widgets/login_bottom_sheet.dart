import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/sign_up_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';
import 'package:hire_up_poc_3/widgets/search_field.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  show(BuildContext context) => showModalBottomSheet(
    showDragHandle: true,
    enableDrag: true,
    backgroundColor: Colors.white,
    constraints: .tightFor(height: 580),
    isScrollControlled: true,
    context: context,
    builder: (context) => this,
  );

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pa(
        child: Column(
          spacing: 12,
          children: [
            '로그인'.text(.new().b24),
            'HireUp에 오신 것을 환영합니다'.text(.new().b16.cg),

            Expanded(
              child: Column(
                mainAxisAlignment: .spaceAround,
                children: [
                  SearchField(
                    key: Key('이메일: test@example.com'),
                    controller: email,
                    p: Icons.email_outlined.icon(color: grey),
                    h: '이메일을 입력해주세요',
                  ),
                  SearchField(
                    key: Key('비밀번호: Test1234!'),
                    controller: password,
                    p: Icons.lock_outline.icon(color: grey),
                    h: '비밀번호를 입력해주세요',
                    hide: true,
                  ),
                ],
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

                '로그인 상태 유지'.text(.new().b14.cg),

                Spacer(),

                TextButton(
                  onPressed: () {
                    '비밀번호 찾기 서비시는 준비중에 있습니다.'.snack(context);
                  },
                  child: '비밀번호 찾기'.text(.new().b14.cb),
                ),
              ],
            ),

            PButton(
              key: Key('정상 값으로 로그인 시도'),
              tap: () async {
                if (await appCtrl.login(
                  context,
                  email: email.text,
                  password: password.text,
                )) {
                  '로그인 성공'.snack(context);
                  context.pop();
                }
              },
              child: ['로그인'.text(.new().b16.cw)],
            ),

            1.sh,

            Row(
              children: [
                Expanded(child: Divider()),
                12.pw(child: '또는'.text(.new().b14.cg)),
                Expanded(child: Divider()),
              ],
            ),

            Row(
              mainAxisAlignment: .center,
              children: [
                '계정이 없으신가요?'.text(.new().b16.cg),
                TextButton(
                  onPressed: () {
                    context
                      ..pop()
                      ..push(SignUpScreen());
                  },
                  child: '회원가입'.text(.new().b16.cb),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
