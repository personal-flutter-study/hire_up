import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_3/app_ctrl.dart';
import 'package:hire_up_poc_3/screens/resum_skill_stack.dart';
import 'package:hire_up_poc_3/screens/resume_career.dart';
import 'package:hire_up_poc_3/screens/resume_general_info.dart';
import 'package:hire_up_poc_3/screens/resume_project.dart';
import 'package:hire_up_poc_3/utils.dart';
import 'package:hire_up_poc_3/widgets/base_scaffold.dart';
import 'package:hire_up_poc_3/widgets/p_button.dart';
import 'package:http/http.dart';

import '../models/resume_detail_model.dart';

int saveId = 0;

ResumeDetailModel? resumeModel;

class EditResumeScreen extends StatefulWidget {
  const EditResumeScreen({super.key, this.id});

  final int? id;

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen>
    with TickerProviderStateMixin {
  late final TabController tab;

  @override
  void initState() {
    tab = TabController(length: 4, vsync: this);

    resumeModel = ResumeDetailModel(
      title: '',
      jobRole: '',
      oneLineIntro: '',
      intro: '',
      educations: <EducationModel>[],
      careers: <CareerModel>[],
      projects: <ProjectModel>[],
      skills: <String>[],
    );

    super.initState();
  }

  Future<bool> save(BuildContext context) async {
    print(
      baseHeader..addAll({'Authorization': 'Bearer ${appCtrl.token.value}'}),
    );

    try {
      final res = await put(
        Uri.parse('$baseUri/resumes').replace(
          queryParameters: {'id': widget.id?.toString()}
            ..removeWhere((key, value) => value == null),
        ),
        headers: Map.of(baseHeader)
          ..addAll({'Authorization': 'Bearer ${appCtrl.token.value}'}),
        body: jsonEncode(resumeModel!.toJson()),
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 201 || res.statusCode == 200) {
        (body['message'] as String?)?.snack(context);

        saveId = body['data']['id'];

        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: '이력서 수정'.text(),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              if (await save(context)) {
                context.pop();
              }
            },
            child: '저장'.text(.new().b14.cb),
          ),
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
            ('기본 정보', Key('')),
            ('겅력', Key('"경력" 탭 클릭')),
            ('프로젝트', Key('"프로젝트" 탭 클릭')),
            ('기술 스텍', Key('"기술 스택" 탭 클릭')),
          ].map((e) => Tab(key: e.$2, child: e.$1.text())).toList(),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: [
              ResumeGeneralInfo(),
              ResumeCareer(),
              ResumeProject(),
              ResumSkillStack(),
            ][tab.index],
          ),
          ColoredBox(
            color: Colors.white,
            child: 18.pa(
              child: PButton(
                key: Key('"저장하기" 버튼 클릭'),
                child: ['저장하기'.text(.new().b16.cw)],
                tap: () async {
                  if (await save(context)) {
                    context.pop();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
