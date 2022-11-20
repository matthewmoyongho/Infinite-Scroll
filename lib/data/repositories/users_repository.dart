import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UsersRepository {
  Future<List<User>?> getUsers(String page, String limit) async {
    //'https://pokeapi.co/api/v2/pokemon/$number'
    //
    try {
      http.Response response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page'));
      List<dynamic> fetchData = jsonDecode(response.body);
      print(fetchData);

      List<User> fetchUsers = [];
      fetchData
          .map(
            (user) => fetchUsers.add(
              User.fromJson(user),
            ),
          )
          .toList();
      return fetchUsers.isEmpty ? null : fetchUsers;
    } catch (err) {
      return null;
    }
    return null;
  }
}
