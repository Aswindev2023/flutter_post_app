import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../providers/post_providers.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_card.dart';
import '../widgets/post_shimmer.dart';
import '../widgets/post_search_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isRefreshing = false;

  // Pull-to-refresh functionality
  Future<void> _refreshPosts() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 100));
    ref.invalidate(postsProvider);
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _isRefreshing = false);
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PostSearchDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final allPostsAsync = ref.watch(postsProvider);
    final filteredPosts = ref.watch(filteredPostsProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const CustomAppBar(title: 'All Posts'),
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: _isRefreshing || allPostsAsync.isLoading
            ? const PostShimmer()
            : allPostsAsync.when(
                data: (_) {
                  if (filteredPosts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: const Text(
                          'No matching posts found.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredPosts.length + 1,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.03,
                          ),
                          child: Text(
                            'Matching Posts: ${filteredPosts.length}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      }
                      return PostCard(post: filteredPosts[index - 1]);
                    },
                  );
                },
                error: (e, _) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
                loading: () => const PostShimmer(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.searchButtonBackground,
        onPressed: () => _showSearchDialog(context),
        child: const Icon(Icons.search, color: AppColors.searchButtonText),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
