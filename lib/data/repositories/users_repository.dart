import 'package:infinite_scroll_test/data/services/users_service.dart';

import '../models/user.dart';

class UsersRepository {
  final UsersService service;
  UsersRepository(this.service);

  Future<List<User>> getUsers(int page) async {
    final usersResponse = await service.fetchUsers(page);
    return usersResponse.map((user) => User.fromJson(user)).toList();
  }
}
