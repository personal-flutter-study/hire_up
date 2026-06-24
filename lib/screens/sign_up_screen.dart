import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/search_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(),
      child: 18.pa(
        child: Column(
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    'assets/images/logo_vertical.png'.image(120),
                    '회원가입'.text(.new().b24),
                    'HireUp 계정을 만들어\n취업 준비를 시작해보세요!'.text(.new().b14.cg),
                  ],
                ),

                'assets/images/sign_up_main_img.png'.image(80),
              ],
            ),

            SearchField(
              h: '이메일을 입력해주세요',
              label: '이메일',
              p: Icons.email_outlined.icon(color: grey),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                SearchField(
                  h: '비밀번호를 입력해주세요',
                  label: '비밀번호',
                  p: Icons.lock_outline.icon(color: grey),
                  hide: true,
                ),

                '8자 이상, 대소문자, 숫자, 특수문자 포함'.text(
                  TextStyle(fontSize: 12, fontWeight: .bold).cg,
                ),
              ],
            ),
            SearchField(
              h: '비밀번호를 다시 입력해주세요',
              label: '비밀번호 확인',
              p: Icons.lock_outline.icon(color: grey),
              hide: true,
            ),
            SearchField(
              h: '이름을 입력해주세요',
              label: '이름',
              p: Icons.person_outline.icon(color: grey),
            ),
          ],
        ),
      ),
    );
  }
}
