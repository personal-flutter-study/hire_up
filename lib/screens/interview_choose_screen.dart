import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/screens/interview_history_screen.dart';
import 'package:hire_up_poc_3/screens/interview_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';

enum JobRole {
  FRONTEND('FRONTEND', '프론트엔드•개발자', Icons.code),
  BACKEND('BACKEND', '벡엔드•개발자', Icons.layers),
  DESIGN('DESIGN', 'UI/UX 디자이너', Icons.bar_chart),
  APP('APP', '모바일 앱 개발자', Icons.lightbulb),
  DATA('DATA', '데이터 분석가', Icons.brush),
  PM('PM', '기획자/PM', Icons.phone_android);

  final String value;
  final String label;
  final IconData icon;

  const JobRole(this.value, this.label, this.icon);
}

enum InterviewType {
  GENERAL('GENERAL', '일반 면접', Icons.chat_bubble_outline, '직무 및 인성 관련 종합 질문'),
  PRACTICAL('PRACTICAL', '실무 면접', Icons.work_outline, '작무 과련 기술 및 경험 질문'),
  PERSONALITY(
    'PERSONALITY',
    '인성 면접',
    Icons.person_outline,
    '인성, 가치관, 조직문화 적합성 질문',
  );

  final String value;
  final String label;
  final IconData icon;
  final String desc;

  const InterviewType(this.value, this.label, this.icon, this.desc);
}

enum Career {
  NEW('NEW', '신입 (0~1년'),
  JUNIOR('JUNIOR', '주니어 (2~3년'),
  MIDDLE('MIDDLE', '미들 (4~7년'),
  SENIOR('SENIOR', '시니어 (8년+');

  final String value;
  final String label;

  const Career(this.value, this.label);
}

class InterviewChooseScreen extends StatefulWidget {
  const InterviewChooseScreen({super.key});

  @override
  State<InterviewChooseScreen> createState() => _InterviewChooseScreenState();
}

class _InterviewChooseScreenState extends State<InterviewChooseScreen> {
  JobRole? jobRole;

  Career? career;

  InterviewType type = .GENERAL;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: 'AI 모의 면접'.text(.new().b18), centerTitle: true),
      child: 18.pw(
        child: SingleChildScrollView(
          child: Column(
            spacing: 18,
            children: [
              Card(
                surfaceTintColor: blue,
                child: SizedBox(
                  height: 180,
                  child: Stack(
                    children: [
                      Align(
                        alignment: .centerLeft,
                        child: 18.pa(
                          child: Column(
                            mainAxisAlignment: .spaceAround,
                            crossAxisAlignment: .start,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Row(
                                    children: [
                                      'AI와 함께 '.text(.new().b24),
                                      '실전처럼'.text(.new().b24.cb),
                                    ],
                                  ),

                                  '면접을 준비해보세요'.text(.new().b24),
                                ],
                              ),

                              '직무별 맞춤 질문으로\n실전 감각을 키울 수 있어요.'.text(.new().cg),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: .bottomRight,
                        child: 'assets/images/ai_interviewer.png'.image(120),
                      ),
                    ],
                  ),
                ),
              ),

              _section(
                '1. 직무 선택',
                '면접을 준비할 직무를 선택해주세요.',
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 70,
                    crossAxisSpacing: 12,
                  ),
                  children: JobRole.values.map((e) {
                    final active = jobRole == e;

                    return ActionChip(
                      color: .all(Colors.white),
                      onPressed: () {
                        setState(() {
                          jobRole = e;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12),
                        side: BorderSide(color: active ? blue : grey),
                      ),
                      label: 8.ph(
                        child: Row(
                          children: [
                            e.icon.icon(color: active ? blue : grey),
                            e.label.text(
                              TextStyle(color: active ? Colors.black : grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              _section(
                '2. 연차 선택',
                '본인의 경력 연차를 선택해주세요.',
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 12,
                    children: Career.values.map((e) {
                      final active = career == e;
                      return ActionChip(
                        onPressed: () {
                          setState(() {
                            career = e;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(32),
                        ),
                        color: .all(active ? blue : Colors.white),
                        label: 4.ph(
                          child: e.label.text(
                            TextStyle(
                              color: active ? Colors.white : Colors.black,
                            ).b14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  '3. 면접 유형 선택 '.text(.new().b18),
                  '특정 주제의 면접을 선택하면 더 맞춤형 질문을 제공해요.'.text(.new().cg),
                  GestureDetector(
                    onTap: () {
                      _InterviewBottomSheet(
                        type: type,
                        change: (type2) {
                          setState(() {
                            type = type2;
                          });
                        },
                      ).show(context);
                    },
                    child: Card(
                      color: Colors.white,
                      child: 18.pa(
                        child: Row(
                          spacing: 12,
                          children: [
                            type.icon.icon(),
                            type.label.text(.new().b14.cg),

                            Spacer(),

                            Icons.keyboard_arrow_down.icon(color: grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              12.sh,

              PButton(
                tap: () {
                  context.push(InterviewScreen());
                },
                child: [
                  Icons.flare.icon(color: Colors.white),
                  12.sw,
                  '면접 시작하기'.text(.new().b16.cw),
                ],
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  padding: .symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  alignment: .center,
                ),
                onPressed: () {
                  context.push(InterviewHistoryScreen());
                },
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: .center,
                  children: [
                    Icons.timer_outlined.icon(color: grey),
                    '이전 면접 기록 보기'.text(.new().b16.cg),
                    Icons.arrow_forward_ios.icon(color: grey),
                  ],
                ),
              ),

              48.sh,
            ],
          ),
        ),
      ),
    );
  }
}

Widget _section(String t, String m, Widget child) => Column(
  spacing: 12,
  crossAxisAlignment: .start,
  children: [t.text(.new().b18), m.text(.new().cg), child],
);

class _InterviewBottomSheet extends StatelessWidget {
  const _InterviewBottomSheet({
    super.key,
    required this.type,
    required this.change,
  });

  final InterviewType type;
  final Function(InterviewType type) change;

  void show(BuildContext context) => showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    context: context,
    builder: (context) => this,
  );

  @override
  Widget build(BuildContext context) {
    return 10.pa(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          8.ph(
            child: Row(
              mainAxisAlignment: .center,
              children: ['면접 유형 선택'.text(.new().b18)],
            ),
          ),

          SizedBox(width: .infinity, child: Divider()),

          ...InterviewType.values.map((e) {
            final activeColor = type == e ? blue : grey;

            return GestureDetector(
              onTap: () {
                change(e);
                context.pop();
              },
              child: Row(
                spacing: 12,
                children: [
                  Card(
                    surfaceTintColor: activeColor,
                    child: 8.pa(child: e.icon.icon(color: activeColor)),
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      e.label.text(TextStyle(color: activeColor).b16),
                      e.desc.text(.new().cg),
                    ],
                  ),

                  Spacer(),

                  if (type == e) Icons.check_circle.icon(color: blue),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
