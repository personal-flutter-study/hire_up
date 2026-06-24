import 'package:hire_up_poc_3/models/job_model.dart';
import 'package:hire_up_poc_3/screens/home_screen.dart';

class RecommendJobModel {
  final int id;
  final String companyName;
  final String companyLogo;
  final String jobTitle;
  final String location;
  final String employmentType;
  final String career;
  final String salary;
  final String deadlineLabel;
  final String dDay;
  final RecruitStatus recruitStatus;

  RecommendJobModel({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.jobTitle,
    required this.location,
    required this.employmentType,
    required this.career,
    required this.salary,
    required this.deadlineLabel,
    required this.dDay,
    required this.recruitStatus,
  });

  factory RecommendJobModel.fromJson(Map json) => RecommendJobModel(
    id: json['id'],
    companyName: json['companyName'],
    companyLogo: json['companyLogo'],
    jobTitle: json['jobTitle'],
    location: json['location'],
    employmentType: json['employmentType'],
    career: json['career'],
    salary: json['salary'],
    deadlineLabel: json['deadlineLabel'],
    dDay: json['dDay'],
    recruitStatus: RecruitStatus.values
        .where((element) => element.value == (json['recruitStatus'] as String))
        .first,
  );

  JobModel toJobModel() => JobModel(
    id: id,
    companyName: companyName,
    companyLogo: companyLogo,
    jobTitle: jobTitle,
    location: location,
    employmentType: employmentType,
    career: career,
    salary: salary,
    deadlineLabel: deadlineLabel,
    viewCount: 0,
    createdAt: DateTime.now(),
  );
}

/*
[
{
"id": 5,
"companyName": "쿠팡",
"companyLogo": "http://localhost:8000/company/coupang.png",
"jobTitle": "퍼포먼스 마케터",
"location": "서울 송파구",
"employmentType": "정규직",
"career": "경력 3년↑",
"salary": "6,000~10,000만원",
"deadlineLabel": "마감",
"dDay": "D+25",
"recruitStatus": "CLOSED"
},*/
