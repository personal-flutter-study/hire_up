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
  final String createdAt;

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
    createdAt: json['createdAt'],
  );
}

/*
{
"id": 9,
"companyName": "직방",
"companyLogo": "http://localhost:3000/company/zigbang.png",
"jobTitle": "프론트엔드 개발자 (React)",
"location": "서울 강남구",
"employmentType": "정규직",
"career": "경력 1년↑",
"salary": "3,500~5,500만원",
"deadlineLabel": "43일 전",
"viewCount": 510,
"createdAt": "2026-06-13T10:00:00+09:00"
},*/
