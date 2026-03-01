import '../core/api_client.dart';
import '../models/sponsored_article.dart';
import '../utils/fields.dart';

/// Repository for handling Sponsored Articles API calls.
class SponsoredArticlesRepository {
  final ApiClient _apiClient;

  SponsoredArticlesRepository(this._apiClient);

  /// Get all active sponsored articles (public)
  Future<List<SponsoredArticle>> getAll() async {
    final articleFields = buildFieldsQuery(preset: ArticlePreset.standard);

    final query = '''
      query GetSponsoredArticles {
        public {
          sponsoredArticles {
            id
            articleId
            coverImage
            isActive
            priority
            startDate
            endDate
            article {
              $articleFields
            }
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetSponsoredArticles',
    );

    final List list = response?['public']?['sponsoredArticles'] ?? [];
    return list.map((e) => SponsoredArticle.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Get a sponsored article by ID (public)
  Future<SponsoredArticle?> getById(int id) async {
    try {
      final response = await _apiClient.dio.get('/api/sponsored-articles/$id');
      if (response.data == null) return null;
      return SponsoredArticle.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  /// Create a new sponsored article (admin only)
  Future<SponsoredArticle?> create(Map<String, dynamic> data) async {
    final response = await _apiClient.dio.post('/api/sponsored-articles', data: data);
    if (response.data == null) return null;
    return SponsoredArticle.fromJson(response.data as Map<String, dynamic>);
  }

  /// Update a sponsored article (admin only)
  Future<SponsoredArticle?> update(int id, Map<String, dynamic> data) async {
    final response = await _apiClient.dio.put('/api/sponsored-articles/$id', data: data);
    if (response.data == null) return null;
    return SponsoredArticle.fromJson(response.data as Map<String, dynamic>);
  }

  /// Delete a sponsored article (admin only)
  Future<bool> delete(int id) async {
    try {
      await _apiClient.dio.delete('/api/sponsored-articles/$id');
      return true;
    } catch (e) {
      return false;
    }
  }
}
