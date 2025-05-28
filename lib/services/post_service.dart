import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  final String baseUrl;

  // Accept baseUrl optionally for testing flexibility
  PostService({String? baseUrl})
      : baseUrl = baseUrl ?? 'https://jsonplaceholder.typicode.com/posts';

  /// Fetch all posts from the API
  Future<List<PostModel>> fetchPosts() async {
    try {
      final responses = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'FlutterApp/1.0',
        },
      );

      if (responses.statusCode == 200) {
        final List data = json.decode(responses.body);
        return data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load posts: ${responses.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Filter a list of posts locally based on optional userId and postId
  List<PostModel> searchPostsLocally({
    required List<PostModel> posts,
    int? userId,
    int? postId,
  }) {
    if (postId != null) {
      return posts.where((post) => post.id == postId).toList();
    }

    if (userId != null) {
      return posts.where((post) => post.userId == userId).toList();
    }

    return posts;
  }
}
