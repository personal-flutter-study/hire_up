class ResumModel {
  final int id;
  final String title;
  final DateTime updatedAt;
  final List<String> skills;

  ResumModel({
    required this.id,
    required this.title,
    required this.updatedAt,
    required this.skills,
  });

  factory ResumModel.fromJson(Map json) => ResumModel(
    id: json['id'],
    title: json['title'],
    updatedAt: DateTime.parse(json['updatedAt']),
    skills: (json['skills'] as List).map((e) => e.toString()).toList(),
  );
}

/*
{
"id": 1,
"title": "모바일 앱 개발자 이력서",
"updatedAt": "2026-06-10T12:00:00+09:00",
"skills": ["Flutter", "Dart", "Firebase"]
}*/
