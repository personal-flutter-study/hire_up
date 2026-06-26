import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/resume_detail_model.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_3/screens/interview_choose_screen.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';

import '../utils.dart';
import '../widgets/search_field.dart';

final ValueNotifier<int> _ticker = ValueNotifier(0);

class ResumeGeneralInfo extends StatefulWidget {
  const ResumeGeneralInfo({super.key});

  @override
  State<ResumeGeneralInfo> createState() => _ResumeGeneralInfoState();
}

class _ResumeGeneralInfoState extends State<ResumeGeneralInfo> {
  final greyL = grey.withAlpha(30);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: Key('학력 영역 "추가" 버튼 클릭 S'),
      child: 18.pa(
        child: Column(
          spacing: 18,
          children: [
            _section(
              '프로필',
              Column(
                spacing: 18,
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    spacing: 18,
                    crossAxisAlignment: .start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          '프로필 사진 수정 서비스는 준비중에 있습니다.'.snack(context);
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: greyL,
                          child: Icons.camera_alt_outlined.icon(
                            color: grey,
                            size: 32,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: .start,
                          children: [
                            SearchField(
                              key: Key('이름 입력 필드에 이름 입력'),
                              label: '이름',
                              color: greyL,
                              h: '',
                            ),

                            '직무'.text(.new().b16.cg),
                            PopupMenuButton(
                              key: Key('직무 드롭다운에서 직무 선택'),
                              onSelected: (value) {
                                setState(() {
                                  resumeModel!.jobRole = value.label;
                                });
                              },
                              color: Colors.white,
                              itemBuilder: (context) => JobRole.values
                                  .map(
                                    (e) => PopupMenuItem(
                                      value: e,
                                      child: e.label.text(),
                                    ),
                                  )
                                  .toList(),
                              child: Container(
                                padding: .symmetric(horizontal: 12),
                                margin: .all(1),
                                decoration: BoxDecoration(
                                  borderRadius: .circular(12),
                                  color: greyL,
                                  border: .all(
                                    color: grey.withAlpha(100),
                                    width: 2,
                                  ),
                                ),
                                child: 16.ph(
                                  child: Row(
                                    children: [
                                      resumeModel!.jobRole.text(.new().b14),

                                      Spacer(),

                                      Icons.keyboard_arrow_down.icon(
                                        color: grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: .center,
                    children: [
                      '한 줄 소개'.text(.new().b16.cg),
                      Container(
                        padding: .symmetric(horizontal: 12),
                        margin: .all(1),
                        decoration: BoxDecoration(
                          borderRadius: .circular(12),
                          color: greyL,
                          border: .all(color: grey.withAlpha(100), width: 2),
                        ),
                        child: TextField(
                          key: Key('한 줄 소개 입력'),
                          maxLength: 50,
                          onChanged: (value) {
                            setState(() {
                              resumeModel!.oneLineIntro = value;
                            });
                          },
                          controller: TextEditingController(
                            text: resumeModel!.oneLineIntro,
                          ),
                          decoration: InputDecoration(
                            border: .none,
                            contentPadding: .symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _section(
              '개인 정보',
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 100,
                ),
                children: [('이메일'), ('연락처'), ('생년월일'), ('위치')]
                    .map(
                      (e) => Column(
                        crossAxisAlignment: .start,
                        children: [
                          e.text(.new().b16.cg),
                          Container(
                            padding: .symmetric(horizontal: 12),
                            margin: .all(1),
                            decoration: BoxDecoration(
                              borderRadius: .circular(12),
                              color: greyL,
                              border: .all(
                                color: grey.withAlpha(100),
                                width: 2,
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: .none,
                                contentPadding: .symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),

            _section(
              '소개',
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: greyL,
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      resumeModel!.intro = value;
                    });
                  },
                  controller: TextEditingController(text: resumeModel!.intro),
                  maxLength: 300,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: .none,
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ),

            Card(
              color: Colors.white,
              child: 18.pa(
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        '학력'.text(.new().b20),

                        Spacer(),

                        TextButton(
                          key: Key('학력 영역 "추가" 버튼 클릭'),
                          style: TextButton.styleFrom(
                            tapTargetSize: .shrinkWrap,
                            padding: .zero,
                            minimumSize: .zero,
                          ),
                          onPressed: () {
                            _EducationBottomSheet().show(context);
                          },
                          child: Row(
                            children: [
                              Icons.add.icon(color: blue),
                              '추가'.text(.new().b14.cb),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: _ticker,
                      builder: (context, _, child) {
                        return Column(
                          children: resumeModel!.educations
                              .map(
                                (e) => Card(
                                  color: Colors.white,
                                  child: 18.pa(
                                    child: Row(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              '${e.schoolName} • ${e.major}'
                                                  .text(.new().b16),
                                              '${e.level} • ${e.enter} - ${e.graduate}'
                                                  .text(.new()),
                                            ],
                                          ),
                                        ),

                                        IconButton(
                                          style: IconButton.styleFrom(
                                            tapTargetSize: .shrinkWrap,
                                            minimumSize: .zero,
                                            padding: .zero,
                                          ),
                                          onPressed: () {
                                            resumeModel!.educations.remove(e);
                                            _ticker.value++;
                                          },
                                          icon: Icons.delete_outline.icon(
                                            color: Colors.red,
                                          ),
                                        ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _section(String m, Widget c) => Card(
  color: Colors.white,
  child: 18.pa(
    child: Column(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [m.text(.new().b20), c],
    ),
  ),
);

class _EducationBottomSheet extends StatelessWidget {
  void show(BuildContext context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    builder: (context) => this,
  );

  final TextEditingController v1 = TextEditingController();

  final TextEditingController v2 = TextEditingController();

  final TextEditingController v3 = TextEditingController();

  final TextEditingController v4 = TextEditingController();

  final TextEditingController v5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 18.pw(
      child: Column(
        spacing: 12,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          '학력 추가'.text(.new().b24),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '학교명'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('학교명: 한국대학교'),
                  controller: v1,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 한국대학교'.text(.new().b16.cg),
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '전공'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('전공: 컴퓨터공학과'),
                  controller: v2,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 컴퓨터공학과'.text(.new().b16.cg),
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '학위'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  controller: v3,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 학사'.text(.new().b16.cg),
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: .start,
                  children: [
                    '졸업'.text(.new().b16.cg),
                    Container(
                      padding: .symmetric(horizontal: 12),
                      margin: .all(1),
                      decoration: BoxDecoration(
                        borderRadius: .circular(12),
                        color: grey.withAlpha(30),
                        border: .all(color: grey.withAlpha(100), width: 2),
                      ),
                      child: TextField(
                        controller: v4,
                        decoration: InputDecoration(
                          border: .none,
                          hint: '예 : YYYY.MM'.text(.new().b16.cg),
                          contentPadding: .symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: .start,
                  children: [
                    '입학'.text(.new().b16.cg),
                    Container(
                      padding: .symmetric(horizontal: 12),
                      margin: .all(1),
                      decoration: BoxDecoration(
                        borderRadius: .circular(12),
                        color: grey.withAlpha(30),
                        border: .all(color: grey.withAlpha(100), width: 2),
                      ),
                      child: TextField(
                        controller: v5,
                        decoration: InputDecoration(
                          border: .none,
                          hint: '예 : YYYY.MM'.text(.new().b16.cg),
                          contentPadding: .symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          18.ph(
            child: PButton(
              key: Key('학교명 입력 후 "저장" 버튼 클릭'),
              child: ['저장'.text(.new().b16.cw)],
              tap: () {
                if (v1.text.isNotEmpty && v2.text.isNotEmpty) {
                  resumeModel!.educations.add(
                    EducationModel(
                      schoolName: v1.text,
                      major: v2.text,
                      level: v3.text,
                      enter: v4.text,
                      graduate: v5.text,
                    ),
                  );
                  _ticker.value++;
                  context.pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
