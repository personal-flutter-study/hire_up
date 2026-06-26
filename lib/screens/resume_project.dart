import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/resume_detail_model.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';

import '../utils.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/p_button.dart';

final ValueNotifier<int> _ticker = ValueNotifier(0);

class ResumeProject extends StatefulWidget {
  const ResumeProject({super.key});

  @override
  State<ResumeProject> createState() => _ResumeProjectState();
}

class _ResumeProjectState extends State<ResumeProject> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pa(
        child: ValueListenableBuilder(
          valueListenable: _ticker,
          builder: (context, value, child) {
            return Column(
              children: [
                ...resumeModel!.projects.map(
                      (e) =>
                      Card(
                        color: Colors.white,
                        child: 18.pa(
                          child: Row(
                            crossAxisAlignment: .start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    e.name.text(.new().b16),
                                    e.period.text(.new().b14.cg),

                                    8.sh,

                                    Row(
                                      children: [
                                        Expanded(
                                          child: e.description.text(
                                                  .new().b14.cg),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            children: e.techStack
                                                .map(
                                                  (e) =>
                                                  Card(
                                                    surfaceTintColor: grey,
                                                    child: 4.pa(
                                                      child: e.text(
                                                              .new().b14.cg),
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
                                style: IconButton.styleFrom(
                                  tapTargetSize: .shrinkWrap,
                                  minimumSize: .zero,
                                  padding: .zero,
                                ),
                                onPressed: () {
                                  resumeModel!.projects.remove(e);
                                  _ticker.value++;
                                },
                                icon: Icons.delete_outline.icon(
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),

                32.sh,

                ElevatedButton(
                  key: Key('"프로젝트 추가" 버튼 클릭'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(12),
                      side: BorderSide(color: blue),
                    ),
                    padding: .symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    alignment: .center,
                  ),
                  onPressed: () {
                    _ProjectBottomSheet().show(context);
                  },
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: .center,
                    children: [
                      Icons.add.icon(color: blue),
                      '프로젝트 추가'.text(.new().b16.cb),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProjectBottomSheet extends StatelessWidget {
  _ProjectBottomSheet({super.key});

  show(context) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => this,
        enableDrag: true,
        showDragHandle: true,
        isScrollControlled: true,
      );

  final TextEditingController v1 = TextEditingController();

  final TextEditingController v2 = TextEditingController();

  final TextEditingController v3 = TextEditingController();

  final TextEditingController v4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 18.pw(
      child: Column(
        spacing: 12,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          '프로젝트 추가'.text(.new().b24),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '프로젝트명'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('프로젝트명: HireUp 채용 플랫폼'),
                  controller: v1,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : HireUp 채용 플렛폼'.text(.new().b16.cg),
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
              '기간'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  controller: v2,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 2024.01 - 2024.06'.text(.new().b16.cg),
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
              '설명'.text(.new().b16.cg),
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
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '프로젝트 내용과 본인의 역할을 입력해주세요'.text(.new().b16.cg),
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
              '사용 기술'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('사용 기술: Flutter, Dart'),
                  controller: v4,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '쉼표로 구분 (예: Flutter, Dart)'.text(.new().b16.cg),
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          18.ph(
            child: PButton(
              key: Key('프로젝트명, 사용 기술 입력 후 "저장" 버튼 클릭'),
              child: ['저장'.text(.new().b16.cw)],
              tap: () {
                if (v1.text.isNotEmpty &&
                    v4.text.isNotEmpty) {
                  resumeModel!.projects.add(
                    ProjectModel(
                      name: v1.text,
                      period: v2.text,
                      description: v3.text,
                      techStack: v4.text.split(','),
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
