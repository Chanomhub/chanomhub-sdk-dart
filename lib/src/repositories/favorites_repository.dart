import '../core/api_client.dart';
import '../models/article.dart';

/// Repository for handling Favorites API calls.
class FavoritesRepository {
  final ApiClient _apiClient;

  FavoritesRepository(this._apiClient);

  /// Add article to favorites (requires authentication)
  Future<Article?> add(String slug) async {
    final response = await _apiClient.dio.post(
      '/api/articles/${Uri.encodeComponent(slug)}/favorite',
    );
    if (response.data == null || response.data['article'] == null) return null;
    return Article.fromJson(response.data['article'] as Map<String, dynamic>);
  }

  /// Remove article from favorites (requires authentication)
  Future<Article?> remove(String slug) async {
    final response = await _apiClient.dio.delete(
      '/api/articles/${Uri.encodeComponent(slug)}/favorite',
    );
    if (response.data == null || response.data['article'] == null) return null;
    return Article.fromJson(response.data['article'] as Map<String, dynamic>);
  }
}
