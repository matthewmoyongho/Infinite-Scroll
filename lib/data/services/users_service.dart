import 'dart:convert';

import 'package:http/http.dart' as http;

class UsersService {
  static const PAGE_LIMIT = '15';
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl?_limit=$PAGE_LIMIT&_page=$page'),
      );
      return jsonDecode(response.body) as List;
    } catch (err) {
      return [];
    }
  }
}
