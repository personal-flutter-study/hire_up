class UserModel {
  final int id;
  final String email;
  final String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map json) =>
      UserModel(id: json['id'], email: json['email'], name: json['name']);
}

/*
{
"id": 2,
"email": "s25013@gsm.hs.kr",
"name": "음창승"
}*/
