import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../providers/post_providers.dart';

class PostSearchDialog extends ConsumerStatefulWidget {
  const PostSearchDialog({super.key});

  @override
  ConsumerState<PostSearchDialog> createState() => _PostSearchDialogState();
}

class _PostSearchDialogState extends ConsumerState<PostSearchDialog> {
  final _userIdController = TextEditingController();
  final _postIdController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _postIdController.dispose();
    super.dispose();
  }

  bool _isValidInput(String value) {
    if (value.isEmpty) return true;
    final numValue = int.tryParse(value);
    return numValue != null && numValue > 0;
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(postSearchQueryProvider);
    final queryNotifier = ref.read(postSearchQueryProvider.notifier);

    _userIdController.text = query.userId?.toString() ?? '';
    _postIdController.text = query.postId?.toString() ?? '';

    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Search Filters',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User ID field
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'User ID',
                hintText: 'Enter User ID',
                filled: true,
                fillColor: AppColors.searchFieldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.searchFieldBorder),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Post ID field
            TextField(
              controller: _postIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Post ID',
                hintText: 'Enter Post ID',
                filled: true,
                fillColor: AppColors.searchFieldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.searchFieldBorder),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.clearButtonBackground,
          ),
          onPressed: () {
            _userIdController.clear();
            _postIdController.clear();
            queryNotifier.state = PostSearchQuery();
            Navigator.pop(context);
          },
          child: const Text(
            'Clear',
            style: TextStyle(color: AppColors.clearButtonText),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.searchButtonBackground,
          ),
          onPressed: () {
            if (!_isValidInput(_userIdController.text) ||
                !_isValidInput(_postIdController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please enter positive integers only')),
              );
              return;
            }

            final userId = int.tryParse(_userIdController.text);
            final postId = int.tryParse(_postIdController.text);

            queryNotifier.state = PostSearchQuery(
              userId: userId,
              postId: postId,
            );
            Navigator.pop(context);
          },
          child: const Text(
            'Search',
            style: TextStyle(color: AppColors.searchButtonText),
          ),
        ),
      ],
    );
  }
}
