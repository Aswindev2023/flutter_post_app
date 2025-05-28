import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/colors.dart';

/// A shimmer effect for loading state while posts are being fetched
class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.03,
      ),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: AppColors.secondary,
        highlightColor: AppColors.primary,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          height: screenWidth * 0.25,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
