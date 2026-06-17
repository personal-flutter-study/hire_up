import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/widgets/search_field.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  void show(BuildContext context) => showBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    builder: (context) => this,
  );

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text('로그인', style: TextStyle().b24),
            Text('HireUp에 오신 것을 환영합니다', style: TextStyle().b14.cg),

            SearchField(
              h: '이메일을 입력해주세요',
              controller: email,
              color: Colors.white.withAlpha(200),
              p: AppIcon.email.icon(color: grey),
            ),
            SearchField(
              h: '비밀번호를 입력해주세요',
              controller: password,
              hide: false,
              color: Colors.white.withAlpha(200),
              p: AppIcon.lock.icon(color: grey),
            ),
          ],
        ),
      ),
    );
  }
}
