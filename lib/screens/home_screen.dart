import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../providers/post_providers.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_card.dart';
import '../widgets/post_shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isRefreshing = false;

  Future<void> _refreshPosts() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(
        const Duration(milliseconds: 100)); // allow shimmer to render
    ref.invalidate(postsProvider); // trigger a reload
    await Future.delayed(const Duration(milliseconds: 400)); // wait for refresh
    setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final postAsync = ref.watch(postsProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const CustomAppBar(title: 'All Posts'),
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: _isRefreshing || postAsync.isLoading
            ? const PostShimmer()
            : postAsync.when(
                data: (posts) => ListView.builder(
                  itemCount: posts.length + 1,
                  padding: const EdgeInsets.only(bottom: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenWidth * 0.03,
                        ),
                        child: Text(
                          'Total Posts: ${posts.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }
                    return PostCard(post: posts[index - 1]);
                  },
                ),
                error: (e, _) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
                loading: () => const PostShimmer(), // fallback if needed
              ),
      ),
    );
  }
}
