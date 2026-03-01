import '../core/api_client.dart';
import '../models/common.dart';

/// Repository for handling Mods API calls.
class ModsRepository {
  final ApiClient _apiClient;

  ModsRepository(this._apiClient);

  /// Create a new mod for an article
  Future<Mod?> create(String slug, Map<String, dynamic> data) async {
    final response = await _apiClient.dio.post('/api/mods/article/$slug', data: data);
    if (response.data == null || response.data['mod'] == null) return null;
    return Mod.fromJson(response.data['mod'] as Map<String, dynamic>);
  }
}
