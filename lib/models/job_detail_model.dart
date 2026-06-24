import 'package:hire_up_poc_3/screens/home_screen.dart';

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
        .where((element) => element.value == (json['recruitStatus'] as String))
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
{
"id": 5,
"companyName": "쿠팡",
"companyLogo": "http://localhost:3000/company/coupang.png",
"jobTitle": "퍼포먼스 마케터",
"recruitStatus": "CLOSED",
"location": "서울 송파구",
"career": "경력 3년↑",
"salary": "6,000~10,000만원",
"employmentType": "정규직",
"deadline": "2026-05-30",
"positionIntro": "로켓배송 브랜드를 알릴 퍼포먼스 마케터를 채용합니다.",
"tasks":[
"온라인 광고 집행 및 성과 분석",
"CPA/ROAS 최적화"
],
"qualifications":[
"퍼포먼스 마케팅 경험 3년 이상",
"GA/Meta Ads 운영 경험"
],
"benefits":[
"성과급",
"스톡옵션",
"글로벌 오피스 경험"
]
}*/
