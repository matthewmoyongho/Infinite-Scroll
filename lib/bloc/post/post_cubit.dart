import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_test/data/repositories/post_repository.dart';

import '../../data/models/post.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.repository) : super(PostInitial());
  int page = 1;
  // int limit = 15;
  final PostRepository repository;

  void loadPost() {
    if (state is PostLoading) return;
    final currentState = state;
    var oldPost = <Post>[];
    if (currentState is PostLoaded) {
      oldPost = currentState.post;
    }
    emit(PostLoading(oldPost, isFirstFetch: page == 1));

    repository.fetchPosts(page).then((newPost) {
      page++;
      final post = (state as PostLoading).oldPost;
      post.addAll(newPost);
      emit(PostLoaded(post));
    });
  }
}
