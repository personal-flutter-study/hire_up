import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/screens/interview_choose_screen.dart';
import 'package:hire_up_poc_3/screens/resume_career.dart';
import 'package:hire_up_poc_3/screens/resume_general_info.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';

import '../models/resume_detail_model.dart';

final resumeCtrl = ResumeCtrl();
final List<EducationModel> educations = [];

class ResumeCtrl {
  final TextEditingController name = TextEditingController();
  JobRole? jobRole;
  final TextEditingController oneLineIntro = TextEditingController();
  final TextEditingController intro = TextEditingController();
}

class EditResumeScreen extends StatefulWidget {
  const EditResumeScreen({super.key});

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen>
    with TickerProviderStateMixin {
  late final TabController tab;

  @override
  void initState() {
    tab = TabController(length: 4, vsync: this);
    educations.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: '이력서 수정'.text(),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () {}, child: '저장'.text(.new().b14.cb)),
        ],
        bottom: TabBar(
          labelColor: blue,
          unselectedLabelColor: grey,
          indicatorColor: blue,
          onTap: (value) {
            setState(() {});
          },
          controller: tab,
          tabs: [
            '기본 정보',
            '겅력',
            '프로젝트',
            '기술 스텍',
          ].map((e) => Tab(child: e.text())).toList(),
        ),
      ),
      child: Column(
        children: [
          Expanded(child: [ResumeGeneralInfo(), ResumeCareer()][tab.index]),
          Container(
            color: Colors.white,
            child: 18.pa(
              child: PButton(child: ['저장하기'.text(.new().b16.cw)], tap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
