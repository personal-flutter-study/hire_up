class UserModel {
  final int id;
  final String email;
  final String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map json) =>
      UserModel(id: json['id'], email: json['email'], name: json['name']);
}

/*

"id": 1,
"email": "test@example.com",
"name": "홍길동"*/
