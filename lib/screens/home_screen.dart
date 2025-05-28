import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_providers.dart';
import '../widgets/post_card.dart';
import '../widgets/post_shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('All Posts')),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(postsProvider),
        child: postAsync.when(
          data: (posts) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Total Posts: ${posts.length}',
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (_, i) => PostCard(post: posts[i]),
                ),
              ),
            ],
          ),
          loading: () => const PostShimmer(),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
