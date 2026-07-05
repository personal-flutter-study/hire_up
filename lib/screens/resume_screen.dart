import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/models/resume_model.dart';
import 'package:hire_up_poc_5/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../utils.dart';
import '../widgets/login_bottom.dart';

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
        title: '이력서'.text(TextStyle().b24),
        centerTitle: true,
        actions: [
          Icons.add.iButton(() async {
            await context.go(EditResumeScreen());
            setState(() {});
          }, size: 32),
        ],
      ),
      child: ListenableBuilder(
        listenable: appCtrl.ticker,
        builder: (context, child) {
          if (appCtrl.token.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                spacing: 12,
                children: [
                  Icons.description_outlined.icon(size: 78, color: grey),

                  SizedBox(height: 12),

                  '로그인이 필요합니다.'.text(TextStyle().b24),
                  '로그인 후 이력서를 관리할 수 있어요'.text(TextStyle().b18.cg),

                  SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: .symmetric(vertical: 16),
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12),
                      ),
                    ),
                    onPressed: () {
                      LoginBottom().show(context);
                    },
                    child: 88.pw(child: '로그인'.text(TextStyle().b16.cw)),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: 18.pa(
              child: Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  Card(
                    color: blue,
                    child: 18.pa(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 12,
                              children: [
                                '나만의 강점을 담은\n이력서를 만들어보세요'.text(
                                  TextStyle().b24.cw,
                                ),
                                '체계적인 이력서 작성으로 합력률을 놓여보세요'.text(TextStyle().cw),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: .symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: .circular(12),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await context.go(EditResumeScreen());
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: .min,
                                    spacing: 12,
                                    mainAxisAlignment: .center,
                                    children: [
                                      Icons.add.icon(color: blue),
                                      '이력서 작성하기'.text(TextStyle().b16.cb),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: .lerp(blue, Colors.white, .5),
                            child: 12.pa(
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

                  '내 이력서'.text(TextStyle().b24),

                  FutureBuilder(
                    future: _load(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == .waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.data;

                      if (data == null) {
                        return Center(child: '조회할 수 없습니다.'.text());
                      }

                      return Column(
                        children: data
                            .map(
                              (e) => GestureDetector(
                                onTap: () async {
                                  await context.go(EditResumeScreen(id: e.id));
                                  setState(() {});
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: 18.pa(
                                    child: Row(
                                      spacing: 12,
                                      children: [
                                        Card(
                                          color: .lerp(blue, Colors.white, .8),
                                          child: 12.pa(
                                            child: Icons.description_outlined
                                                .icon(color: blue, size: 32),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            spacing: 8,
                                            children: [
                                              e.title.text(TextStyle().b18),
                                              '최종 수정 ${DateFormat('yyyy.MM.dd hh:mm').format(e.updatedAt)}'
                                                  .text(TextStyle().b16.cg),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Wrap(
                                                      children: e.skills
                                                          .take(3)
                                                          .map(
                                                            (e) => Card(
                                                              surfaceTintColor:
                                                                  grey,
                                                              child: e.text(),
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

                                        Icons.more_horiz_rounded.iButton(() {
                                          _Detail().show(context);
                                        }, color: grey),
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

class _Detail extends StatelessWidget {
  const _Detail({super.key});

  show(context) =>
      showModalBottomSheet(context: context, builder: (context) => this);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            spacing: 12,
            children: [Icons.edit.icon(), '수정'.text(TextStyle().b16)],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            spacing: 12,
            children: [Icons.star.icon(), '대표 이력서로 설정'.text(TextStyle().b16)],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            spacing: 12,
            children: [Icons.copy.icon(), '복제'.text(TextStyle().b16)],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            spacing: 12,
            children: [
              Icons.delete.icon(color: Colors.red),
              '삭제'.text(TextStyle(color: Colors.red).b16),
            ],
          ),
        ),
      ],
    );
  }
}

Future<List<ResumeModel>> _load() async {
  try {
    final res = await get(Uri.parse('${baseUrl}/resumes'), headers: authHeader);

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return (body['data']['items'] as List)
          .map((e) => ResumeModel.fromJson(e))
          .toList();
    }
  } catch (e) {
    print(e);
  }

  return [];
}
