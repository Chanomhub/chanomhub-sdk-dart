import 'package:dio/dio.dart';
import '../core/api_client.dart';
import '../models/auth.dart';

/// Repository for handling Authentication API calls.
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  /// Helper to get the default User-Agent if required by the API
  Map<String, String> get _defaultHeaders => {
    'user-agent': 'ChanomhubFlutterSDK/1.0.0', // Standardize this later
  };

  /// Register a new user.
  Future<UserResponse> register({
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/users',
      options: Options(headers: _defaultHeaders),
      data: {
        'user': {'email': email, 'username': username, 'password': password},
      },
    );

    return UserResponse.fromJson(response.data);
  }

  /// Login an existing user.
  Future<UserResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/users/login',
      options: Options(headers: _defaultHeaders),
      data: {
        'user': {'email': email, 'password': password},
      },
    );

    return UserResponse.fromJson(response.data);
  }

  /// Refresh the access token using a refresh token.
  Future<TokenPairDTO> refresh(String refreshToken) async {
    final response = await _apiClient.dio.post(
      '/api/auth/refresh',
      options: Options(headers: _defaultHeaders),
      data: {'refreshToken': refreshToken},
    );

    return TokenPairDTO.fromJson(response.data);
  }

  /// Logout from the current device (revokes the refresh token).
  Future<void> logout(String refreshToken) async {
    await _apiClient.dio.post(
      '/api/auth/logout',
      data: {'refreshToken': refreshToken},
    );
  }

  /// Logout from all devices for the current authenticated user.
  Future<void> logoutAll() async {
    await _apiClient.dio.post('/api/auth/logout-all');
  }
}
