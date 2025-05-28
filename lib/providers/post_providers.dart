import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_app/models/post_model.dart';

import '../services/post_service.dart';

final postServiceProvider = Provider<PostService>((ref) => PostService());

final postsProvider = FutureProvider<List<PostModel>>((ref) async {
  return ref.read(postServiceProvider).fetchPosts();
});
