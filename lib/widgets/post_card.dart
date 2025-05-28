import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../constants/colors.dart';

/// A styled card to display each post item
class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: AppColors.secondary,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.02,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post ID: ${post.id} | User ID: ${post.userId}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.035,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              post.title,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: screenWidth * 0.015),
            Text(
              post.body,
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                color: AppColors.textSecondary,
                height: 1.5,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
