import '../core/api_client.dart';
import '../models/user.dart';

/// Repository for handling Users and Profile API calls.
class UsersRepository {
  final ApiClient _apiClient;

  UsersRepository(this._apiClient);

  /// Get current logged-in user
  Future<User?> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get('/api/user');
      if (response.data == null || response.data['user'] == null) return null;
      return User.fromJson(response.data['user'] as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  /// Get public profile by username
  Future<Profile?> getProfile(String username) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/profiles/${Uri.encodeComponent(username)}',
      );
      if (response.data == null || response.data['profile'] == null) return null;
      return Profile.fromJson(response.data['profile'] as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  /// Follow a user
  Future<Profile?> follow(String username) async {
    final response = await _apiClient.dio.post(
      '/api/profiles/${Uri.encodeComponent(username)}/follow',
    );
    if (response.data == null || response.data['profile'] == null) return null;
    return Profile.fromJson(response.data['profile'] as Map<String, dynamic>);
  }

  /// Unfollow a user
  Future<Profile?> unfollow(String username) async {
    final response = await _apiClient.dio.delete(
      '/api/profiles/${Uri.encodeComponent(username)}/follow',
    );
    if (response.data == null || response.data['profile'] == null) return null;
    return Profile.fromJson(response.data['profile'] as Map<String, dynamic>);
  }
}
