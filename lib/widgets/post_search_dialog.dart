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
  void initState() {
    super.initState();
    final query = ref.read(postSearchQueryProvider);
    _userIdController.text = query.userId?.toString() ?? '';
    _postIdController.text = query.postId?.toString() ?? '';
  }

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
    final queryNotifier = ref.read(postSearchQueryProvider.notifier);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.02;
    final borderRadius = screenWidth * 0.02;
    final fontSizeTitle = screenWidth * 0.05;
    final fontSizeInput = screenWidth * 0.04;
    final spacingLarge = screenHeight * 0.025;
    final spacingMedium = screenHeight * 0.015;

    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: Text(
        'Search Filters',
        style: TextStyle(
          fontSize: fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // User ID field
              TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: fontSizeInput),
                decoration: InputDecoration(
                  labelText: 'User ID',
                  hintText: 'Enter User ID',
                  filled: true,
                  fillColor: AppColors.searchFieldBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide:
                        const BorderSide(color: AppColors.searchFieldBorder),
                  ),
                ),
              ),
              SizedBox(height: spacingLarge),

              // Post ID field
              TextField(
                controller: _postIdController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: fontSizeInput),
                decoration: InputDecoration(
                  labelText: 'Post ID',
                  hintText: 'Enter Post ID',
                  filled: true,
                  fillColor: AppColors.searchFieldBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide:
                        const BorderSide(color: AppColors.searchFieldBorder),
                  ),
                ),
              ),
              SizedBox(height: spacingMedium),
            ],
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding * 0.6,
        vertical: verticalPadding * 0.5,
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.clearButtonBackground,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.015,
            ),
            textStyle: TextStyle(fontSize: fontSizeInput),
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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.015,
            ),
            textStyle: TextStyle(fontSize: fontSizeInput),
          ),
          onPressed: () {
            if (!_isValidInput(_userIdController.text) ||
                !_isValidInput(_postIdController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter positive integers only'),
                ),
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
