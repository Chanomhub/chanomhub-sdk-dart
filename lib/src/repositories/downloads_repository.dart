import '../core/api_client.dart';
import '../models/common.dart';
import '../models/download.dart';

/// Repository for handling Download Link API calls.
class DownloadsRepository {
  final ApiClient _apiClient;

  DownloadsRepository(this._apiClient);

  /// Create a new download link
  Future<DownloadLink?> create(Map<String, dynamic> data) async {
    final response = await _apiClient.dio.post('/api/downloads', data: data);
    if (response.data == null || response.data['downloadLink'] == null) return null;
    return DownloadLink.fromJson(response.data['downloadLink'] as Map<String, dynamic>);
  }

  /// Get all download links for a specific article
  Future<List<DownloadLink>> getByArticle(int articleId) async {
    const query = r'''
      query GetArticleDownloads($articleId: Int!) {
        public {
          article(id: $articleId) {
            downloads {
              id
              name
              url
              isActive
              vipOnly
              forVersion
              createdAt
              updatedAt
            }
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'articleId': articleId},
      operationName: 'GetArticleDownloads',
    );

    final List downloadsList = response?['public']?['article']?['downloads'] ?? [];
    return downloadsList.map((e) => DownloadLink.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Get a specific download link by ID
  Future<DownloadLink?> getById(int id) async {
    final response = await _apiClient.dio.get('/api/downloads/$id');
    if (response.data == null) return null;
    return DownloadLink.fromJson(response.data as Map<String, dynamic>);
  }

  /// Update a download link
  Future<DownloadLink?> update(int id, Map<String, dynamic> data) async {
    final response = await _apiClient.dio.patch('/api/downloads/$id', data: data);
    if (response.data == null || response.data['downloadLink'] == null) return null;
    return DownloadLink.fromJson(response.data['downloadLink'] as Map<String, dynamic>);
  }

  /// Delete a download link
  Future<bool> delete(int id) async {
    try {
      await _apiClient.dio.delete('/api/downloads/$id');
      return true;
    } catch (e) {
      return false;
    }
  }
}
