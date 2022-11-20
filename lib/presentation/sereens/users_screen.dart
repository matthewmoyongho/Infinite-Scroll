import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_test/bloc/users/users_event.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../bloc/users/users_bloc.dart';
import '../../bloc/users/users_state.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            final users = state.users;
            if (state is UsersLoaded) {
              return LazyLoadScrollView(
                onEndOfPage: () {
                  context.read<UsersBloc>().add(LoadUsers());
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.title),
                      subtitle: Text(user.body),
                      trailing: Text(user.id),
                    );
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
