import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hire_up_poc_5/app_ctrl.dart';
import 'package:hire_up_poc_5/utils.dart';
import 'package:hire_up_poc_5/widgets/base_scaffold.dart';
import 'package:hire_up_poc_5/widgets/login_bottom.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../models/resume_send_model.dart';

part 'resume_info.dart';

part 'resume_car.dart';

part 'resume_pro.dart';

enum JobRole {
  FRONTEND('FRONTEND', '프론트엔드'),
  BACKEND('BACKEND', '백엔드'),
  DATA('DATA', '데이터 분석'),
  PM('PM', '기획/PM'),
  DESIGN('DESIGN', '디자인'),
  APP('APP', '앱 개발');

  final String v;
  final String l;

  const JobRole(this.v, this.l);
}

File? _image;
TextEditingController _na = TextEditingController();
JobRole? _role;
TextEditingController _oneLineIntro = TextEditingController();
TextEditingController _em = TextEditingController();
TextEditingController _ph = TextEditingController();
TextEditingController _bir = TextEditingController();
TextEditingController _loc = TextEditingController();
TextEditingController _intro = TextEditingController();
TextEditingController _lin = TextEditingController();

List<Edu> _educations = [];
List<Car> _careers = [];
List<Pro> _projects = [];
List<String> _skills = [];

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: Icons.arrow_back_ios.iButton(() {
          context.back();
        }),
        title: '이력서 수정'.text(TextStyle().b24),
        centerTitle: true,
        actions: [
          '저장'.tButton(() async {
            if (await _save(widget.id)) {
              context.back();
            }
          }, tStyle: TextStyle().b16.cb),
        ],
        bottom: TabBar(
          onTap: (value) {
            setState(() {});
          },
          controller: tab,
          indicatorColor: blue,
          labelColor: blue,
          unselectedLabelColor: grey,
          labelStyle: TextStyle().b16,
          tabs: [
            Tab(text: '기본 정보'),
            Tab(text: '경력'),
            Tab(text: '프로젝트'),
            Tab(text: '기술 스택'),
          ],
        ),
      ),
      child: ListenableBuilder(
        listenable: appCtrl.ticker,
        builder: (context, child) {
          print(_educations.length);

          return Column(
            children: [
              Expanded(
                child: 18.pa(child: [_Info(), _Car(), _Pro()][tab.index]),
              ),

              Container(
                color: Colors.white,
                child: 18.pa(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: .symmetric(vertical: 16),
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (await _save(widget.id)) {
                        context.back();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: ['저장하기'.text(TextStyle().b16.cw)],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<bool> _save([int? id]) async {
  try {
    final res = await put(
      Uri.parse('${baseUrl}/resumes').replace(
        queryParameters: {'id': id}..removeWhere((key, value) => value == null),
      ),
      headers: authHeader..addAll(baseHeader),
      body: jsonEncode({
        "title": _na.text,
        "jobRole": _role?.l,
        "oneLineIntro": _oneLineIntro.text,
        "intro": _intro.text,
        "educations": _educations.map((e) => e.toJson()).toList(),
        "careers": _careers.map((e) => e.toJson()).toList(),
        "projects": _projects.map((e) => e.toJson()).toList(),
        "skills": _skills,
      }),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      print(res.statusCode);
      '이력서가 저장되었습니다'.toast();

      return true;
    } else {
      for (var element in (body['errors'] as List)) {
        (element['message'] as String).toast();
      }
    }
  } catch (e) {
    print(e);
  }
  return false;
}
