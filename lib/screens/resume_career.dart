import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/models/resume_detail_model.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';

import '../utils.dart';

final ValueNotifier<int> _ticker = ValueNotifier(0);

class ResumeCareer extends StatefulWidget {
  const ResumeCareer({super.key});

  @override
  State<ResumeCareer> createState() => _ResumeCareerState();
}

class _ResumeCareerState extends State<ResumeCareer> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: 18.pa(
        child: ValueListenableBuilder(
          valueListenable: _ticker,
          builder: (context, value, child) {
            return Column(
              children: [
                ...resumeModel!.careers.map(
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
                                '${e.companyName} • ${e.position}'.text(
                                  .new().b16,
                                ),
                                '${e.startDate} - ${e.isCurrent ? '재직중' : e.endDate}'
                                    .text(.new().b14.cg),

                                8.sh,

                                Row(
                                  children: [
                                    Expanded(
                                      child: e.description.text(.new().b14.cg),
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
                              resumeModel!.careers.remove(e);
                              _ticker.value++;
                            },
                            icon: Icons.delete_outline.icon(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                32.sh,

                ElevatedButton(
                  key: Key('"경력 추가" 버튼 클릭'),
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
                    _CareerBottomSheet().show(context);
                  },
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: .center,
                    children: [
                      Icons.add.icon(color: blue),
                      '경력 추가'.text(.new().b16.cb),
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

class _CareerBottomSheet extends StatefulWidget {
  const _CareerBottomSheet({super.key});

  show(context) => showModalBottomSheet(
    context: context,
    builder: (context) => this,
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
  );

  @override
  State<_CareerBottomSheet> createState() => _CareerBottomSheetState();
}

class _CareerBottomSheetState extends State<_CareerBottomSheet> {
  final TextEditingController v1 = TextEditingController();

  final TextEditingController v2 = TextEditingController();

  final TextEditingController v3 = TextEditingController();

  final TextEditingController v4 = TextEditingController();

  final TextEditingController v5 = TextEditingController();

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return 18.pw(
      child: Column(
        spacing: 12,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          '경력 추가'.text(.new().b24),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '회사명'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('회사명: 테크스타트업'),
                  controller: v1,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 테크스타트업'.text(.new().b16.cg),
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
              '직책'.text(.new().b16.cg),
              Container(
                padding: .symmetric(horizontal: 12),
                margin: .all(1),
                decoration: BoxDecoration(
                  borderRadius: .circular(12),
                  color: grey.withAlpha(30),
                  border: .all(color: grey.withAlpha(100), width: 2),
                ),
                child: TextField(
                  key: Key('직책: 모바일 앱 개발자'),
                  controller: v2,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '예 : 프론트엔드 개발자'.text(.new().b16.cg),
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
                    '입사'.text(.new().b16.cg),
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
                    '퇴사'.text(.new().b16.cg),
                    Container(
                      padding: .symmetric(horizontal: 12),
                      margin: .all(1),
                      decoration: BoxDecoration(
                        borderRadius: .circular(12),
                        color: grey.withAlpha(30),
                        border: .all(color: grey.withAlpha(100), width: 2),
                      ),
                      child: TextField(
                        enabled: !check,
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
            ],
          ),

          Row(
            children: [
              Checkbox(
                value: check,
                onChanged: (value) {
                  setState(() {
                    check = value ?? false;
                    if (check == true) {
                      v4.clear();
                    }
                  });
                },
              ),

              '재직 중'.text(.new().b14),
            ],
          ),

          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              '담당 업무'.text(.new().b16.cg),
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
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: .none,
                    hint: '주요 업무와 성과를 입력해주세요'.text(.new().b16.cg),
                    contentPadding: .symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          18.ph(
            child: PButton(
              key: Key('회사명, 직책 입력 후 "저장" 버튼 클릭'),
              child: ['저장'.text(.new().b16.cw)],
              tap: () {
                if (v1.text.isNotEmpty && v2.text.isNotEmpty) {
                  resumeModel!.careers.add(
                    CareerModel(
                      companyName: v1.text,
                      position: v2.text,
                      startDate: v3.text,
                      endDate: v4.text,
                      description: v5.text,
                      isCurrent: check,
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
