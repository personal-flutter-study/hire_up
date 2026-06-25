import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/resum_model.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:http/http.dart';

import '../app_ctrl.dart';
import '../utils.dart';
import '../widgets/login_bottom_sheet.dart';
import '../widgets/p_button.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: '이력서'.text(.new().b24),
        actions: [
          IconButton(
            onPressed: () {
              context.push(EditResumeScreen());
            },
            icon: Icons.add.icon(size: 38),
          ),
        ],
        centerTitle: true,
      ),
      child: ValueListenableBuilder(
        valueListenable: appCtrl.token,
        builder: (context, value, child) {
          if (value == null) {
            return Center(
              child: Column(
                spacing: 8,
                mainAxisAlignment: .center,
                children: [
                  Icons.description_outlined.icon(size: 88, color: grey),
                  '로그인이 필요합니다'.text(.new().b18),
                  '로그인 후 이력서를 관리할 수 있어요'.text(.new().b16.cg),
                  12.sh,
                  100.pw(
                    child: PButton(
                      child: ['로그인'.text(.new().b16.cw)],
                      tap: () {
                        LoginBottomSheet().show(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: .circular(32)),
                  color: blue,
                  child: 22.pa(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 12,
                            crossAxisAlignment: .start,
                            children: [
                              '나만의 강점을 담은\n이력서를 만들어보세요'.text(.new().b20.cw),
                              '체계적인 이력서 작성으로 합격률을 높여보세요'.text(.new().cw),

                              ActionChip(
                                onPressed: () {
                                  context.push(EditResumeScreen());
                                },
                                color: .all(Colors.white),
                                label: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Icons.add.icon(color: blue),
                                    '이력서 작성하기'.text(.new().b16.cb),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: .lerp(blue, Colors.white, .3),
                          child: 18.pa(
                            child: Icons.description_outlined.icon(
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                '내 이력서'.text(.new().b20),

                FutureBuilder(
                  future: _load(context),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState == .waiting)
                      return Center(child: CircularProgressIndicator());

                    return Column(
                      children: (asyncSnapshot.data ?? [])
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                context.push(EditResumeScreen());
                              },
                              child: Card(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Card(
                                      surfaceTintColor: blue,
                                      child: Icons.description_outlined.icon(
                                        color: blue,
                                      ),
                                    ),
                                    Column(children: []),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<List<ResumModel>> _load(BuildContext context) async {
  try {
    final res = await get(Uri.parse('$baseUri/resumes'));
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return (body['data']['items'] as List)
          .map((e) => ResumModel.fromJson(e))
          .toList();
    }
  } catch (e) {
    print(e);
    '이력서 목록 조회 실패'.snack(context);
  }
  return [];
}
