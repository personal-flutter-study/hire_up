import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/resum_model.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

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
        toolbarHeight: 60,
        title: '이력서'.text(.new().b24),
        actions: [
          IconButton(
            key: Key('앱바 추가(+) 버튼 클릭'),
            onPressed: () async {
              await context.push(EditResumeScreen());
              setState(() {});
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
                      key: Key('"로그인" 버튼 클릭'),
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
            key: Key('생성된 이력서 카드 위치까지 스크롤 S'),
            child: 18.pa(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: .circular(32)),
                    color: blue,
                    child: 22.pa(
                      child: Row(
                        spacing: 12,
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

                  24.sh,

                  '내 이력서'.text(.new().b20),

                  12.sh,

                  FutureBuilder(
                    future: _load(context),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState == .waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return Column(
                        children: (asyncSnapshot.data ?? [])
                            .map(
                              (e) => GestureDetector(
                                onTap: () async {
                                  await context.push(EditResumeScreen());
                                  setState(() {});
                                },
                                child: Card(
                                  key: Key('생성된 이력서 카드 위치까지 스크롤 ${e.id}'),
                                  color: Colors.white,
                                  child: 18.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Card(
                                          surfaceTintColor: blue,
                                          child: 8.pa(
                                            child: Icons.description_outlined
                                                .icon(color: blue, size: 32),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              e.title.text(.new().b20),
                                              '최종 수정 ${DateFormat('yyyy.MM.dd HH:mm').format(e.updatedAt)}'
                                                  .text(.new().b14.cg),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Wrap(
                                                      children: e.skills
                                                          .map(
                                                            (e) => Card(
                                                              surfaceTintColor:
                                                                  grey,
                                                              child: e.text(
                                                                .new().b14.cg,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            _MoreBottomSheet().show(context);
                                          },
                                          icon: Icons.more_horiz.icon(
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    ),
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
            ),
          );
        },
      ),
    );
  }
}

Future<List<ResumModel>> _load(BuildContext context) async {
  try {
    final res = await get(
      Uri.parse('$baseUri/resumes'),
      headers: {'Authorization': 'Bearer ${appCtrl.token.value}'},
    );
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

class _MoreBottomSheet extends StatefulWidget {
  const _MoreBottomSheet({super.key});

  show(context) => showModalBottomSheet(
    context: context,
    builder: (context) => this,
    showDragHandle: true,
    enableDrag: true,
    isScrollControlled: true,
  );

  @override
  State<_MoreBottomSheet> createState() => _MoreBottomSheetState();
}

class _MoreBottomSheetState extends State<_MoreBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisSize: .min,
      children: [
        ...[
          (Icons.edit, '수정', () {}),
          (Icons.star, '대표 이력서로 설정', () {}),
          (Icons.copy, '복제', () {}),
        ].map(
          (e) => GestureDetector(
            onTap: () {},
            behavior: .opaque,
            child: 18.pa(
              child: Row(
                spacing: 24,
                children: [e.$1.icon(size: 32), e.$2.text(.new().b18)],
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: '이력서를 작세하시겠어요?'.text(),
                actions: [
                  CupertinoButton(
                    child: '취소'.text(),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  CupertinoButton(
                    child: '확인'.text(),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          },
          behavior: .opaque,
          child: 18.pa(
            child: Row(
              spacing: 24,
              children: [
                Icons.delete_outline.icon(size: 32, color: Colors.red),
                '삭제'.text(TextStyle(color: Colors.red).b18),
              ],
            ),
          ),
        ),

        24.sh,
      ],
    );
  }
}
