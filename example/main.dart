import 'package:chanomhub_flutter/chanomhub_flutter.dart';

void main() async {
  // Initialize the SDK with the base URL of the Chanomhub API
  final sdk = ChanomhubClient(
    baseUrl: 'https://api.chanomhub.com',
    cdnUrl: 'https://imgproxy.chanomhub.com',
  );

  print('===========================================');
  print('🧪 Testing Chanomhub SDK 🧪');
  print('===========================================');

  try {
    print('\n[1] Testing Articles Module (getArticles)...');

    // Fetch 5 latest articles
    final response = await sdk.articles.getAllPaginated(
      options: ArticleListOptions(limit: 5),
    );

    print(
      '✅ Successfully fetched ${response.items.length} articles (Total: ${response.total})',
    );
    for (var article in response.items) {
      print('  📄 ${article.title} (Slug: ${article.slug})');
    }

    print('\n-------------------------------------------');

    print('\n[2] Testing Auth Module (login with invalid credentials)...');

    // Attempt login with a dummy account to demonstrate error parsing
    try {
      await sdk.auth.login(
        email: 'test@example.com',
        password: 'wrongpassword',
      );
      print('❌ Login succeeded unexpectedly.');
    } on UnauthorizedException catch (e) {
      print('✅ Caught expected UnauthorizedException: ${e.message}');
    } on ChanomhubException catch (e) {
      print('⚠️ Caught other API error: ${e.message}');
    }

    print('\n-------------------------------------------');
  } catch (e) {
    print('❌ An error occurred during the test: $e');
  } finally {
    // Clean up connections when done
    print('\nCleaning up and disposing client...');
    sdk.dispose();
  }
}
