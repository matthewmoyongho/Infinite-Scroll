import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_test/bloc/users/users_event.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../bloc/users/users_bloc.dart';
import '../../bloc/users/users_state.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void loadUser(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<UsersBloc>(context).add(LoadUsers());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).add(LoadUsers());
    loadUser(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            //final users = state.users;

            if (state is UsersLoading && state.isFirstFetch == true) {
              return _loadingIndicator();
            }
            List users = [];
            bool loading = false;

            if (state is UsersLoading) {
              loading = true;
              users = state.oldUsers;
            } else if (state is UsersLoaded) {
              users = state.users;
            }
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                final user = users[index];
                if (index < users.length) {
                  return ListTile(
                    title: Text(user.title),
                    subtitle: Text(user.body),
                    trailing: Text(user.id),
                  );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return _loadingIndicator();
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: users.length + (loading ? 1 : 0),
            );

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

Widget _loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
