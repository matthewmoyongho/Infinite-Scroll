import 'dart:convert';

import 'package:http/http.dart' as http;

class PostService {
  static const FETCH_LIMIT = 15;
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl?_limit=$FETCH_LIMIT&_page=$page'),
      );
      return jsonDecode(response.body) as List;
    } catch (err) {
      return [];
    }
  }
}
