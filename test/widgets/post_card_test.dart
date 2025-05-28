import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post_app/models/post_model.dart';
import 'package:post_app/widgets/post_card.dart';

void main() {
  testWidgets('PostCard displays post data correctly',
      (WidgetTester tester) async {
    final post = PostModel(
      userId: 1,
      id: 10,
      title: 'Sample Title',
      body: 'Sample Body',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostCard(post: post),
        ),
      ),
    );

    // Assert presence of text
    expect(find.text('Post ID: 10 | User ID: 1'), findsOneWidget);
    expect(find.text('Sample Title'), findsOneWidget);
    expect(find.text('Sample Body'), findsOneWidget);
  });
}
