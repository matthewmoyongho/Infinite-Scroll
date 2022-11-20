import '../../data/models/post.dart';

class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<Post> post;

  PostLoaded(this.post);
}

class PostLoading extends PostState {
  final List<Post> oldPost;
  final bool isFirstFetch;
  PostLoading(this.oldPost, {this.isFirstFetch = false});
}
