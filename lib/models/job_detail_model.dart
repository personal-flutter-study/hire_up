import 'package:hire_up_poc_1/widgets/utils.dart';

class JobDetailModel {
  final int id;
  final String companyName;
  final String companyLogo;
  final String jobTitle;
  final RecruitStatus recruitStatus;
  final String location;
  final String career;
  final String salary;
  final String employmentType;
  final String deadline;
  final String positionIntro;
  final List<String> tasks;
  final List<String> qualifications;
  final List<String> benefits;

  JobDetailModel({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.jobTitle,
    required this.recruitStatus,
    required this.location,
    required this.career,
    required this.salary,
    required this.employmentType,
    required this.deadline,
    required this.positionIntro,
    required this.tasks,
    required this.qualifications,
    required this.benefits,
  });

  factory JobDetailModel.fromJson(Map json) => JobDetailModel(
    id: json['id'],
    companyName: json['companyName'],
    companyLogo: json['companyLogo'],
    jobTitle: json['jobTitle'],
    recruitStatus: RecruitStatus.values
        .where((element) => element.value == json['recruitStatus'] as String)
        .first,
    location: json['location'],
    career: json['career'],
    salary: json['salary'],
    employmentType: json['employmentType'],
    deadline: json['deadline'],
    positionIntro: json['positionIntro'],
    tasks: (json['tasks'] as List).map((e) => e.toString()).toList(),
    qualifications: (json['qualifications'] as List)
        .map((e) => e.toString())
        .toList(),
    benefits: (json['benefits'] as List).map((e) => e.toString()).toList(),
  );
}

/*
"data":{
"id": 2,
"companyName": "네이버",
"companyLogo": "http://localhost:3000/company/naver.png",
"jobTitle": "백엔드 개발자",
"recruitStatus": "OPEN",
"location": "경기 성남시 분당구",
"career": "경력 2년↑",
"salary": "4,500~7,000만원",
"employmentType": "정규직",
"deadline": "2026-07-15",
"positionIntro": "글로벌 서비스를 만드는 백엔드 개발자를 채용합니다.",
"tasks":[
"RESTful API 개발",
"대용량 트래픽 처리 시스템 설계"
],
"qualifications":[
"Java/Spring 경험",
"MySQL/Redis 경험"
],
"benefits":[
"스톡옵션",
"유연근무",
"사내 카페테리아"
]
}*/
