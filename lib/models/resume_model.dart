class ResumeModel {
  final int id;
  final String title;
  final DateTime updatedAt;
  final List<String> skills;

  ResumeModel({
    required this.id,
    required this.title,
    required this.updatedAt,
    required this.skills,
  });

  factory ResumeModel.fromJson(Map json) => ResumeModel(
    id: json['id'],
    title: json['title'],
    updatedAt: DateTime.parse(json['updatedAt']),
    skills: (json['skills'] as List).map((e) => e.toString()).toList(),
  );
}

/*
[
{
"id": 1,
"title": "프론트엔드 개발자 이력서",
"updatedAt": "2026-07-02T05:58:31+09:00",
"skills":["React", "JavaScript", "TypeScript", "HTML/CSS", "Next.js"]
}*/
