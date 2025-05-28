Post App

A Flutter application that fetches posts from an API, displays them in a list with styled cards, and supports searching posts locally. Built with clean architecture, proper testing, and well-structured code.

Folder Structure:

lib/
├── constants/           # App-wide constants (e.g., colors)
├── models/              # Data models (PostModel)
├── providers/           # Riverpod providers
├── screens/             # Major app screens
├── services/            # API and platform service logic
├── widgets/             # Custom widgets (AppBar, cards, etc.)
└── main.dart            # App entry point

Features:

- Fetches posts from JSONPlaceholder API

- Local search by userId and postId

- Clean and modular UI

- Shimmer loading state

- Unit, widget, and integration testing

- Follows Flutter best practices

Setup Instructions:

1.Clone the repository
 
 git clone https://github.com/your-username/post_app.git
 cd post_app

2.Install dependencies
 
 flutter pub get

3.Run the app

 flutter run

Testing:

1.Unit Tests

flutter test test/services/post_service_test.dart

2.Widget Tests

flutter test test/widgets/post_card_test.dart

3.Integration Tests

flutter test integration_test/fetch_posts_flow_test.dart

Dependencies:

dependencies:
  flutter:
    sdk: flutter
  http: ^1.4.0
  flutter_riverpod: ^2.6.1
  shimmer: ^3.0.0
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mockito: ^5.4.4
  build_runner: ^2.4.11
  test: ^1.25.2
  integration_test:
    sdk: flutter