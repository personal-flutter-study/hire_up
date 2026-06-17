import 'package:hire_up_poc_1/main.dart';

class JobModel {
  final int id;
  final String companyName;
  final String companyLogo;
  final String jobTitle;
  final String location;
  final String employmentType;
  final String career;
  final String salary;
  final String deadlineLabel;
  final int viewCount;
  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.jobTitle,
    required this.location,
    required this.employmentType,
    required this.career,
    required this.salary,
    required this.deadlineLabel,
    required this.viewCount,
    required this.createdAt,
  });

  factory JobModel.fromJson(Map json) => JobModel(
    id: json['id'],
    companyName: json['companyName'],
    companyLogo: json['companyLogo'],
    jobTitle: json['jobTitle'],
    location: json['location'],
    employmentType: json['employmentType'],
    career: json['career'],
    salary: json['salary'],
    deadlineLabel: json['deadlineLabel'],
    viewCount: json['viewCount'],
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

/*
"id": 13,
"companyName": "프로토파이",
"companyLogo": "http://10.53.68.43:8000/company/protopie.png",
"jobTitle": "UX 디자이너",
"location": "서울 강남구",
"employmentType": "정규직",
"career": "경력 1년↑",
"salary": "3,500~5,000만원",
"deadlineLabel": "39일 전",
"viewCount": 390,
"createdAt": "2026-06-14T09:00:00+09:00"*/
