import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_test/bloc/post/post_cubit.dart';
import 'package:infinite_scroll_test/bloc/post/post_state.dart';

import '../../data/models/post.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostCubit>(context).loadPost();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostCubit>(context).loadPost();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      bool loading = false;
      if (state is PostLoading && state.isFirstFetch) {
        return _centerLoading();
      }

      List<Post> post = [];
      if (state is PostLoading) {
        loading = true;
        post = state.oldPost;
      } else if (state is PostLoaded) {
        post = state.post;
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < post.length) {
              return _post(post[index], context);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return _centerLoading();
            }
          },
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
              ),
          itemCount: post.length + (loading ? 1 : 0));
    });
  }

  Widget _centerLoading() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${post.id}. ${post.title}',
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(post.body),
        ],
      ),
    );
  }
}
