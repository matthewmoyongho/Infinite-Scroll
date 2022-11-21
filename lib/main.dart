import 'package:flutter/material.dart';
import 'package:infinite_scroll_test/data/repositories/post_repository.dart';
import 'package:infinite_scroll_test/data/repositories/users_repository.dart';
import 'package:infinite_scroll_test/data/services/post_service.dart';
import 'package:infinite_scroll_test/data/services/users_service.dart';
import 'package:infinite_scroll_test/presentation/app.dart';

void main() {
  runApp(
    App(
      repository: PostRepository(PostService()),
      usersRepository: UsersRepository(UsersService()),
    ),
  );
}
