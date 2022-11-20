import 'package:infinite_scroll_test/data/models/post.dart';
import 'package:infinite_scroll_test/data/services/post_service.dart';

class PostRepository {
  final PostService service;

  PostRepository(this.service);
  Future<List<Post>> fetchPosts(int page) async {
    final fetchedPost = await service.fetchPosts(page);
    return fetchedPost.map((post) => Post.fromJson(post)).toList();
  }
}
