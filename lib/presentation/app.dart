import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_test/bloc/post/post_cubit.dart';
import 'package:infinite_scroll_test/data/repositories/post_repository.dart';
import 'package:infinite_scroll_test/data/repositories/users_repository.dart';
import 'package:infinite_scroll_test/presentation/sereens/users_screen.dart';

import '../bloc/users/users_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.repository, required this.usersRepository})
      : super(key: key);
  final UsersRepository usersRepository;
  final PostRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UsersBloc(usersRepository)),
        BlocProvider(
          create: (context) => PostCubit(repository),
        ),
      ],
      child: MaterialApp(
        home: UsersScreen(),
      ),
    );
  }
}
