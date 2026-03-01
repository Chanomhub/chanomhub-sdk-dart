# Chanomhub Flutter SDK

[![pub package](https://img.shields.io/pub/v/chanomhub_flutter.svg)](https://pub.dev/packages/chanomhub_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://github.com/Chanomhub/chanomhub-sdk-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/Chanomhub/chanomhub-sdk-dart/actions)

A professional, feature-rich Flutter SDK for the **Chanomhub API**. This package provides a seamless way to interact with Chanomhub's backend, supporting both GraphQL and REST operations with automated image processing.

---

## 🌟 Features

- ⚡ **GraphQL v2 Integration**: High-performance data fetching with custom field selection (Presets).
- 🖼️ **Auto Image Transform**: Automated `imgproxy` URL generation for all image fields.
- 🔐 **Full Auth Support**: Login, Registration, Token Refresh, and Session Management.
- 📦 **Complete Modules**: 
    - **Articles**: Search, Filter, and Paginated article lists.
    - **Users**: Profile management, Follow/Unfollow system.
    - **Downloads**: Manage download links with VIP & Versioning support.
    - **Subscriptions**: Access plans and user subscription status.
    - **Mods & Sponsored**: Specialized modules for community content and promotions.
- 🛠️ **Robust Error Handling**: Domain-specific exceptions for easy debugging.

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  chanomhub_flutter: ^1.0.0
```

Then run:
```bash
flutter pub get
```

---

## 🚦 Quick Start

### Initialize the Client

```dart
import 'package:chanomhub_flutter/chanomhub_flutter.dart';

final sdk = ChanomhubClient(
  baseUrl: 'https://api.chanomhub.com',
  cdnUrl: 'https://imgproxy.chanomhub.com', // Required for image processing
  token: 'YOUR_AUTH_TOKEN', // Optional: for authenticated requests
);
```

### Fetch Articles (GraphQL)

```dart
// Fetch paginated articles with 'standard' field preset
final response = await sdk.articles.getAllPaginated(
  options: ArticleListOptions(limit: 10, offset: 0),
);

for (var article in response.items) {
  print(article.title);
  print(article.mainImage); // Automatically transformed to imgproxy URL!
}
```

### Search Articles

```dart
final searchResult = await sdk.search.articles(
  'visual novel',
  options: SearchOptions(tag: 'Thai'),
);
```

---

## 🎨 Image Processing (Imgproxy)

All image fields returned by the SDK are automatically transformed based on the `cdnUrl` provided. You can also manually transform URLs using the `resolveImageUrl` utility:

```dart
final customUrl = resolveImageUrl(
  article.mainImage,
  sdk.cdnUrl,
  options: ImgproxyOptions(
    width: 300,
    height: 200,
    resizeType: 'fill',
    format: 'webp',
  ),
);
```

---

## 🧩 Advanced Usage

### Authentication Flow

```dart
try {
  final response = await sdk.auth.login(
    email: 'user@example.com',
    password: 'secure_password',
  );
  print('Welcome, ${response.user.username}!');
  
  // Re-initialize or update headers with the new token
  sdk.dio.options.headers['Authorization'] = 'Bearer ${response.user.token}';
} on UnauthorizedException {
  print('Invalid credentials!');
} on ChanomhubException catch (e) {
  print('API Error: ${e.message}');
}
```

---

## 🧪 Testing

The SDK comes with a built-in mock testing suite. To run the tests:

```bash
flutter test
```

---

## 📄 License

This SDK is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue on [GitHub](https://github.com/Chanomhub/chanomhub-sdk-dart).
