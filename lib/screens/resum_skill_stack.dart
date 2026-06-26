import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/screens/edit_resume_screen.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';

class ResumSkillStack extends StatefulWidget {
  const ResumSkillStack({super.key});

  @override
  State<ResumSkillStack> createState() => _ResumSkillStackState();
}

class _ResumSkillStackState extends State<ResumSkillStack> {
  final TextEditingController skill = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: 18.pa(
              child: Column(
                spacing: 18,
                crossAxisAlignment: .start,
                children: [
                  '기술 스택'.text(.new().b20),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: .symmetric(horizontal: 12),
                          margin: .all(1),
                          decoration: BoxDecoration(
                            borderRadius: .circular(12),
                            color: grey.withAlpha(30),
                            border: .all(color: grey.withAlpha(100), width: 2),
                          ),
                          child: TextField(
                            key: Key('기술: Flutter'),
                            maxLines: 1,
                            controller: skill,
                            decoration: InputDecoration(
                              border: .none,
                              hintText: '기술을 입력하고 추가하세요 (예: Flutter, Dart)',
                              hintStyle: .new().b16.cg,
                              contentPadding: .symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        key: Key('기술 입력 후 추가 버튼 클릭'),
                        onTap: () {
                          final list = resumeModel!.skills.toSet()
                            ..add(skill.text);
                          resumeModel!.skills.clear();
                          resumeModel!.skills.addAll(list);
                          setState(() {});
                        },
                        child: Card(
                          color: blue,
                          child: 12.pa(
                            child: Icons.add.icon(
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: resumeModel!.skills
                              .map(
                                (e) => Chip(
                                  label: e.text(.new().b14.cb),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: .circular(32),
                                  ),
                                  deleteIcon: Icons.close.icon(color: blue),
                                  onDeleted: () {
                                    resumeModel!.skills.remove(e);
                                    setState(() {});
                                  },
                                  color: .all(blue.withAlpha(30)),
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
          ),
        ],
      ),
    );
  }
}
