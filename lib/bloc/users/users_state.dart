import '../../data/models/user.dart';

class UsersState {
  List<User> users;
  UsersState({this.users = const []});
}

class UsersLoaded extends UsersState {
  @override
  List<User> users;
  UsersLoaded(this.users);
}

class UserError extends UsersState {
  String message;
  UserError(this.message);
}

class UsersLoading extends UsersState {
  List<User> oldUsers;
  bool isFirstFetch;
  UsersLoading(this.oldUsers, {this.isFirstFetch = false});
}
