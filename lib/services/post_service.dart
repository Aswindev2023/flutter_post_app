import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts ';

  Future<List<PostModel>> fetchPosts() async {
    try {
      final responses = await http.get(Uri.parse(baseUrl));
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
}
