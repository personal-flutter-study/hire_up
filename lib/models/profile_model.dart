class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String intro;
  final int bookmarkCount;
  final int interviewCount;
  final int resumeCount;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.intro,
    required this.bookmarkCount,
    required this.interviewCount,
    required this.resumeCount,
  });

  factory ProfileModel.fronJson(Map json) => ProfileModel(
    id: json['user']['id'],
    name: json['user']['name'],
    email: json['user']['email'],
    intro: json['user']['intro'],

    bookmarkCount: json['stats']['bookmarkCount'],

    interviewCount: json['stats']['interviewCount'],

    resumeCount: json['stats']['resumeCount'],
  );
}

/*
{
"user":{
"id": 1,
"name": "홍길동",
"email": "test@example.com",
"intro": "성장하는 개발자입니다"
},
"stats":{
"bookmarkCount": 5,
"interviewCount": 3,
"resumeCount": 1
}*/
