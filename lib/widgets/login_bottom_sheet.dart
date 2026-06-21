import 'package:flutter/material.dart';
import 'package:hire_up_poc_2/app_ctrl.dart';
import 'package:hire_up_poc_2/screens/sign_up_screen.dart';
import 'package:hire_up_poc_2/utils.dart';
import 'package:hire_up_poc_2/widgets/base_scaffold.dart';
import 'package:hire_up_poc_2/widgets/search_field.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  Future<dynamic> show(BuildContext context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => this,
  );

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  bool check = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        child: Column(
          spacing: 10,
          children: [
            '로그인'.text(.new().b24),
            'HireUp에 오신 것을 환영합니다'.text(.new().b16.cg),

            12.sh,

            SearchField(
              controller: email,
              h: '이메일을 입력해주세요',
              p: Icons.email_outlined.icon(color: grey),
            ),
            SearchField(
              controller: password,
              h: '비밀번호를 입력해주세요',
              p: Icons.lock_outline.icon(color: grey),
              hide: true,
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
                  style: ButtonStyle().min,
                  onPressed: () {},
                  child: '비밀번호 찾기'.text(.new().b14.cb),
                ),
              ],
            ),

            12.ph(
              child: SizedBox(
                width: .infinity,
                child: AppButton.primaru(() async {
                  if (await appCtrl.login(
                    context,
                    email: email.text,
                    password: password.text,
                  )) {
                    context.back();
                  }
                }, '로그인'),
              ),
            ),

            Row(
              children: [
                Expanded(child: Divider(endIndent: 12)),

                '또는'.text(.new().b14.cg),

                Expanded(child: Divider(indent: 12)),
              ],
            ),

            Row(
              mainAxisAlignment: .center,
              children: [
                '계정이 없으신가요?'.text(.new().b14.cg),
                TextButton(
                  onPressed: () {
                    context.go(SignUpScreen());
                  },
                  child: '회원가입'.text(.new().b14.cb),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
