import 'package:chanomhub_flutter/chanomhub_flutter.dart';

void main() async {
  // 1. Initialize the SDK
  final sdk = ChanomhubClient(
    baseUrl: 'https://api.chanomhub.com',
    cdnUrl: 'https://imgproxy.chanomhub.com',
  );

  print('🧪 Chanomhub SDK Test Drive 🧪');

  try {
    // 2. Fetch Latest Articles
    print('\n[Fetching Articles...]');
    final response = await sdk.articles.getAllPaginated(
      options: ArticleListOptions(limit: 3),
    );

    print('✅ Found ${response.total} articles total.');
    for (var article in response.items) {
      print('  📄 ${article.title}');
      print('  🖼️ Image: ${article.mainImage}'); // Auto-transformed URL
    }

    // 3. Search for a specific query
    print('\n[Searching for "visual novel" with Thai tag...]');
    final searchResult = await sdk.search.articles(
      'visual novel',
      options: SearchOptions(tag: 'Thai', limit: 2),
    );
    print('✅ Search found ${searchResult.items.length} results.');

    // 4. Test Error Handling (Invalid Login)
    print('\n[Testing Error Handling (Invalid Login)...]');
    try {
      await sdk.auth.login(
        email: 'invalid@example.com',
        password: 'wrong_password',
      );
    } on AuthenticationException catch (e) {
      print('✅ Caught expected exception: ${e.message} (Status: ${e.statusCode})');
    }

  } catch (e) {
    print('❌ Unexpected error: $e');
  } finally {
    sdk.dispose();
  }
}
