import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_1/main.dart';
import 'package:hire_up_poc_1/screeens/ai_interview_history_screen.dart';
import 'package:hire_up_poc_1/screeens/ai_interview_screen.dart';
import 'package:hire_up_poc_1/widgets/base_scaffold.dart';
import 'package:hire_up_poc_1/widgets/utils.dart';
import 'package:http/http.dart';

import '../models/question_model.dart';

final interviewCtrl = InterviewCtrl();

class InterviewCtrl {
  JobRole? jobRole;
  Career? career;


  final ValueNotifier<InterViewType> type = ValueNotifier(.general);

  final ValueNotifier<List<QuestionModel>> questions = ValueNotifier([]);
  int total = 0;
  final ValueNotifier<int> index = ValueNotifier(0);
  int sec = 0;

  QuestionModel get question => questions.value[index.value];

  void next() {
    index.value = min(index.value + 1, total - 1);
  }

  Future<void> interview(BuildContext context) async {
    if (jobRole == null) {
      '직무를 선택해 주세요'.snack(context);
      return;
    }
    if (career == null) {
      '연차를 선택해 주세요'.snack(context);
      return;
    }

    index.value = 0;
    sec = 0;

    await loadQuestionList();

    context.go(AiInterviewScreen());
  }

  Future<bool> loadQuestionList() async {
    try {
      final res = await get(
        Uri.parse('$baseUrl/interview/questions').replace(
          queryParameters: {
            'jobRole': jobRole?.value,
            'career': career?.value,
            'type': type.value.value,
          }..removeWhere((key, value) => value == null),
        ),
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        total = body['data']['total'];
        questions.value = (body['data']['questions'] as List)
            .map((e) => QuestionModel.fromJson(e))
            .toList();
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}

class AiInterviewChooseScreen extends StatelessWidget {
  const AiInterviewChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pw(
        Column(
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [18.ph('AI 모의 면접'.text(TextStyle().b18))],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: .start,
                  children: [
                    1.sh,

                    _card,
                    _JobRoleSection(),
                    _CareerSection(),
                    _InterviewSection(),

                    1.sh,

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                        backgroundColor: blue,
                        padding: .symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        interviewCtrl.interview(context);
                      },
                      child: Row(
                        spacing: 12,
                        mainAxisAlignment: .center,
                        children: [
                          Icons.auto_awesome.icon(color: Colors.white),

                          Text(
                            '면접 시작하기',
                            style: TextStyle(color: Colors.white).b18,
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                        backgroundColor: Colors.white,
                        padding: .symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        context.go(AiInterviewHistoryScreen());
                      },
                      child: Row(
                        spacing: 12,
                        mainAxisAlignment: .center,
                        children: [
                          Icons.access_time_outlined.icon(color: grey),
                          Text('이전 면접 기록 보기', style: TextStyle().b18.cg),
                          Icons.arrow_forward_ios.icon(color: grey),
                        ],
                      ),
                    ),

                    38.sh,
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

class _JobRoleSection extends StatefulWidget {
  const _JobRoleSection({super.key});

  @override
  State<_JobRoleSection> createState() => _JobRoleSectionState();
}

class _JobRoleSectionState extends State<_JobRoleSection> {
  @override
  Widget build(BuildContext context) {
    return _section(
      '1. 직무 선택',
      '면접을 준비할 직무를 선택해주세요.',
      GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 58,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        children: JobRole.values
            .map(
              (e) => GestureDetector(
                onTap: () {
                  setState(() {
                    interviewCtrl.jobRole = e;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: interviewCtrl.jobRole == e
                        ? .all(color: blue)
                        : null,
                    borderRadius: .circular(12),
                  ),
                  alignment: .center,
                  padding: .symmetric(horizontal: 12),
                  child: Row(
                    spacing: 4,
                    children: [
                      e.icon.icon(
                        color: interviewCtrl.jobRole == e ? blue : grey,
                      ),
                      e.label.text(
                        TextStyle(
                          color: interviewCtrl.jobRole == e
                              ? Colors.black
                              : grey,
                        ).b14,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CareerSection extends StatefulWidget {
  const _CareerSection({super.key});

  @override
  State<_CareerSection> createState() => _CareerSectionState();
}

class _CareerSectionState extends State<_CareerSection> {
  @override
  Widget build(BuildContext context) {
    return _section(
      '2. 연차 선택',
      '본인의 경력 연차를 선택해주세요.',
      SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          spacing: 12,
          children: Career.values
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      interviewCtrl.career = e;
                    });
                  },
                  child: Chip(
                    shape: RoundedRectangleBorder(borderRadius: .circular(32)),
                    padding: .all(12),
                    color: .all(
                      interviewCtrl.career == e ? blue : Colors.white,
                    ),
                    label: e.label.text(
                      TextStyle(
                        color: interviewCtrl.career == e
                            ? Colors.white
                            : Colors.black,
                      ).b14,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _InterviewSection extends StatefulWidget {
  const _InterviewSection({super.key});

  @override
  State<_InterviewSection> createState() => _InterviewSectionState();
}

class _InterviewSectionState extends State<_InterviewSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          spacing: 4,
          children: [
            '3. 면접 유형 선택'.text(.new().b18),
            '(선택)'.text(TextStyle().b14.cg),
          ],
        ),
        12.ph('특정 주제의 면접을 선택하면 더 맞춤형 질문을 제공해요.'.text(.new().b14.cg)),
        ValueListenableBuilder(
          valueListenable: interviewCtrl.type,
          builder: (context, value, child) => GestureDetector(
            onTap: () async {
              _InterviewBottomSheet().show(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: .circular(12),
              ),
              alignment: .center,
              padding: .symmetric(horizontal: 12),
              child: 16.ph(
                Row(
                  spacing: 8,
                  children: [
                    value.icon.icon(color: grey),
                    value.label.text(TextStyle().b14),
                    Spacer(),
                    Icons.keyboard_arrow_down.icon(color: grey),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _section(String t1, String t2, Widget child) => Column(
  crossAxisAlignment: .start,
  children: [t1.text(.new().b18), 12.ph(t2.text(.new().b14.cg)), child],
);
final _card = SizedBox(
  height: 160,
  width: .infinity,
  child: Card(
    color: blueL,
    child: Stack(
      children: [
        Align(
          alignment: .centerLeft,
          child: 18.pa(
            Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisSize: .min,
                  children: [
                    'AI와 함께 '.text(.new().b18),
                    '실전처럼'.text(.new().b18.cb),
                  ],
                ),

                '면접을 준비해보세요'.text(.new().b18),

                Spacer(),

                '직무별 맞춤 질문으로'.text(.new().b14.cg),
                '실전 감각을 키울 수 있어요.'.text(.new().b14.cg),
              ],
            ),
          ),
        ),

        Align(
          alignment: .bottomRight,
          child: AppImg.ai_interviewer.image(size: 120),
        ),
      ],
    ),
  ),
);

class _InterviewBottomSheet extends StatelessWidget {
  const _InterviewBottomSheet({super.key});

  Future<void> show(BuildContext context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => this,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: .min,
        children: [
          '면접 유형 선택'.text(.new().b18),
          18.sh,
          SizedBox(width: .infinity, child: Divider()),

          18.pa(
            Column(
              spacing: 18,
              children: [_line(.general), _line(.real), _line(.mind)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(InterViewType type) {
    final color = type == interviewCtrl.type.value ? blue : grey;
    return Builder(
      builder: (context) {
        return GestureDetector(
          behavior: .opaque,
          onTap: () {
            interviewCtrl.type.value = type;
            context.back();
          },
          child: Row(
            spacing: 8,
            children: [
              Card(child: 12.pa(type.icon.icon(color: color))),
              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  type.label.text(
                    TextStyle(color: color == blue ? blue : Colors.black).b16,
                  ),
                  type.description.text(TextStyle().b14.cg),
                ],
              ),

              Spacer(),

              if (color == blue)
                CircleAvatar(
                  radius: 12,
                  backgroundColor: blue,
                  child: Icons.check.icon(color: Colors.white),
                ),
            ],
          ),
        );
      },
    );
  }
}
