import 'package:flutter_test/flutter_test.dart';
import 'package:post_app/models/post_model.dart';
import 'package:post_app/services/post_service.dart';

void main() {
  late PostService postService;

  setUp(() {
    postService = PostService();
  });

  group('searchPostsLocally', () {
    final samplePosts = [
      PostModel(userId: 1, id: 1, title: 'Post 1', body: 'Body 1'),
      PostModel(userId: 2, id: 2, title: 'Post 2', body: 'Body 2'),
      PostModel(userId: 1, id: 3, title: 'Post 3', body: 'Body 3'),
    ];

    test('should return all posts when no filters are applied', () {
      final results = postService.searchPostsLocally(posts: samplePosts);
      expect(results.length, 3);
    });

    test('should filter posts by userId', () {
      final results =
          postService.searchPostsLocally(posts: samplePosts, userId: 1);
      expect(results.length, 2);
      expect(results.every((post) => post.userId == 1), true);
    });

    test('should filter posts by postId', () {
      final results =
          postService.searchPostsLocally(posts: samplePosts, postId: 2);
      expect(results.length, 1);
      expect(results.first.id, 2);
    });

    test('should prioritize postId over userId', () {
      final results = postService.searchPostsLocally(
          posts: samplePosts, userId: 1, postId: 2);
      expect(results.length, 1);
      expect(results.first.id, 2);
    });

    test('should return empty list if no post matches', () {
      final results =
          postService.searchPostsLocally(posts: samplePosts, userId: 99);
      expect(results.isEmpty, true);
    });
  });
}
