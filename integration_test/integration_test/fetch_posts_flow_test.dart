import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:post_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fetch posts and display them', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Wait for posts to load
    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    // Check if at least one post is shown
    final titleFinder = find.textContaining('Post');
    expect(titleFinder, findsWidgets);
    // Optionally test scrolling
    await tester.fling(listFinder, const Offset(0, -300), 1000);
    await tester.pumpAndSettle();

    // Still expect to find posts
    expect(titleFinder, findsWidgets);
  });
}
