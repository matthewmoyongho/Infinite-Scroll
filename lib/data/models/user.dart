import 'dart:convert';

class User {
  String title;
  String id;
  String body;
  User({required this.id, required this.title, required this.body});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'id': id});
    result.addAll({'body': body});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
