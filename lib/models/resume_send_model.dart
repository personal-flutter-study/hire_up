import 'package:flutter/material.dart';

class ResumeSendModel {
  final String title;
  final String jobRole;
  final String oneLineIntro;
  final String intro;
  final List<Edu> educations;
  final List<Car> careers;
  final List<Pro> projects;

  ResumeSendModel({
    required this.title,
    required this.jobRole,
    required this.oneLineIntro,
    required this.intro,
    required this.educations,
    required this.careers,
    required this.projects,
  });

  Map toJson() => {
    'title': title,
    'jobRole': jobRole,
    'oneLineIntro': oneLineIntro,
    'intro': intro,
    'educations': educations.map((e) => e.toJson()).toList(),
    'careers': careers.map((e) => e.toJson()).toList(),
    'projects': projects.map((e) => e.toJson()).toList(),
  };
}

class Edu {
  final String schoolName;
  final String major;

  Edu({required this.schoolName, required this.major});

  Map toJson() => {'schoolName': schoolName, 'major': major};
}

class Car {
  final String companyName;
  final String position;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String description;

  Car({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
  });

  Map toJson() => {
    'companyName': companyName,
    'position': position,
    'startDate': startDate,
    'endDate': endDate,
    'isCurrent': isCurrent,
    'description': description,
  };
}

class Pro {
  final String name;
  final String period;
  final String description;
  final String techStack;

  Pro({
    required this.name,
    required this.period,
    required this.description,
    required this.techStack,
  });

  Map toJson() => {
    'name': name,
    'period': period,
    'description': description,
    'techStack': techStack,
  };
}

/*
{
"title": "모바일 앱 개발자 이력서",
"jobRole": "모바일 앱 개발자",
"oneLineIntro": "성장하는 개발자입니다",
"intro": "사용자 경험을 중시하는 모바일 개발자입니다.",
"educations": [
{ "schoolName": "한국대학교", "major": "컴퓨터공학과" }
],
"careers": [
{ "companyName": "테크스타트업", "position": "모바일 앱 개발자", "startDate": "2023-01", "endDate": "", "isCurrent": true, "description": "앱 개발" }
],
"projects": [
{ "name": "HireUp 채용 플랫폼", "period": "2024.01~2024.06", "description": "취업 준비 앱", "techStack": ["Flutter", "Dart"] }
],*/
