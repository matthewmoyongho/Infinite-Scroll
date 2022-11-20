import 'dart:convert';

class Post {
  String id;
  String title;
  String body;
  Post({required this.id, required this.body, required this.title});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'body': body});

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  //factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
  Post.fromJson(Map map)
      : id = map['id'].toString(),
        title = map['title'],
        body = map['body'];
}
