class ResumeDetailModel {
  final String title;
  final String jobRole;
  final String oneLineIntro;
  final String intro;
  final educations;
  final careers;
  final projects;
  final List<String> skills;

  ResumeDetailModel({
    required this.title,
    required this.jobRole,
    required this.oneLineIntro,
    required this.intro,
    required this.educations,
    required this.careers,
    required this.projects,
    required this.skills,
  });

  factory ResumeDetailModel.fromJson(Map json) => ResumeDetailModel(
    title: json['title'],
    jobRole: json['jobRole'],
    oneLineIntro: json['oneLineIntro'],
    intro: json['intro'],
    educations: json['educations'],
    careers: json['careers'],
    projects: json['projects'],
    skills: List<String>.from(json['skills']),
  );
}

class EducationModel {
  final String schoolName;
  final String major;
  final String level;
  final String enter;
  final String graduate;

  EducationModel({
    required this.schoolName,
    required this.major,
    required this.level,
    required this.enter,
    required this.graduate,
  });

  factory EducationModel.fromJson(Map json) => EducationModel(
    schoolName: json['schoolName'],
    major: json['major'],
    level: '',
    enter: '',
    graduate: '',
  );

  get toJson => {'schoolName': schoolName, 'major': major};
}

class CareerModel {
  final String companyName;
  final String position;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String description;

  CareerModel({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
  });

  factory CareerModel.fromJson(Map json) => CareerModel(
    companyName: json['companyName'],
    position: json['position'],
    startDate: json['startDate'],
    endDate: json['endDate'],
    isCurrent: json['isCurrent'],
    description: json['description'],
  );

  get toJson => {
    'companyName': companyName,
    'position': position,
    'startDate': startDate,
    'endDate': endDate,
    'isCurrent': isCurrent,
    'description': description,
  };
}

class ProjectModel {
  final String name;
  final String period;
  final String description;
  final List<String> techStack;

  ProjectModel({
    required this.name,
    required this.period,
    required this.description,
    required this.techStack,
  });

  factory ProjectModel.fromJson(Map json) => ProjectModel(
    name: json['name'],
    period: json['period'],
    description: json['description'],
    techStack: List<String>.from(json['techStack']),
  );

  get toJson => {
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
],
"skills": ["Flutter", "Dart"]
}*/
