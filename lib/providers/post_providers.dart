import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_app/models/post_model.dart';

import '../services/post_service.dart';

final postServiceProvider = Provider<PostService>((ref) => PostService());

/// Fetches all posts from the service
final postsProvider = FutureProvider<List<PostModel>>((ref) async {
  return ref.read(postServiceProvider).fetchPosts();
});

/// Holds the current search query: userId and postId (both optional)
final postSearchQueryProvider = StateProvider<PostSearchQuery>((ref) {
  return PostSearchQuery();
});

/// Filters posts using the searchPostsLocally method from PostService
final filteredPostsProvider = Provider<List<PostModel>>((ref) {
  final postsAsync = ref.watch(postsProvider);
  final query = ref.watch(postSearchQueryProvider);
  final postService = ref.read(postServiceProvider);

  return postsAsync.maybeWhen(
    data: (posts) {
      return postService.searchPostsLocally(
        posts: posts,
        userId: query.userId,
        postId: query.postId,
      );
    },
    orElse: () => [],
  );
});

/// Class to hold search filters
class PostSearchQuery {
  final int? userId;
  final int? postId;

  PostSearchQuery({this.userId, this.postId});
}
