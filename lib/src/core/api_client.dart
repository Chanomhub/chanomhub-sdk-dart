import 'package:dio/dio.dart';
import 'exceptions.dart';
import '../transforms/image_url.dart';

/// The core API client responsible for making HTTP requests.
class ApiClient {
  final Dio _dio;
  final String _cdnUrl;
  final String _storageUrl;

  ApiClient({
    required String baseUrl,
    required String cdnUrl,
    String storageUrl = defaultStorageUrl,
    Dio? dioOverride,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
  })  : _cdnUrl = cdnUrl,
        _storageUrl = storageUrl,
        _dio =
            dioOverride ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: connectTimeout,
                receiveTimeout: receiveTimeout,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    // Add default interceptors.
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

    // Custom Error Interceptor.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          // Parse DioException into ChanomhubException.
          handler.next(_parseException(error) as DioException);
        },
      ),
    );
  }

  /// Exposes the Dio instance, primarily for adding/removing interceptors.
  Dio get dio => _dio;

  String get cdnUrl => _cdnUrl;
  String get storageUrl => _storageUrl;

  /// Executes a GraphQL query.
  Future<Map<String, dynamic>?> graphqlQuery(
    String query, {
    Map<String, dynamic> variables = const {},
    String? operationName,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v2/graphql',
        data: {
          'query': query,
          'variables': variables,
          if (operationName != null) 'operationName': operationName,
        },
      );

      final data = response.data;
      if (data == null) {
        throw const ChanomhubException('Empty response from GraphQL API');
      }

      if (data['errors'] != null && (data['errors'] as List).isNotEmpty) {
        final errors = data['errors'] as List;
        final firstError = errors.first as Map<String, dynamic>;
        
        String message = firstError['message']?.toString() ?? 'GraphQL Error';
        String code = 'GRAPHQL_ERROR';
        
        // Extract detailed validation info if available
        if (firstError['extensions'] != null) {
            final extensions = firstError['extensions'] as Map<String, dynamic>;
            if (extensions['code'] != null) {
                code = extensions['code'].toString();
            }
            // For validation errors, append field details if present
            if (extensions['invalidArgs'] != null) {
                message += ' (Invalid args: ${extensions['invalidArgs']})';
            }
        }

        throw ChanomhubException(message, code: code);
      }

      // Transform image URLs in the response data
      final transformedData = transformImageUrlsDeep(data['data'], _cdnUrl);
      return transformedData as Map<String, dynamic>?;
    } on DioException catch (e) {
      // Re-throw if it's already our custom exception (from interceptor)
      if (e is ChanomhubException) rethrow;
      throw _parseException(e);
    }
  }

  /// Helper to convert DioException into domain-specific exceptions.
  Exception _parseException(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return NetworkException(
        'Network error: Please check your internet connection.',
        originalError: error,
      );
    }

    final response = error.response;
    if (response != null) {
      final statusCode = response.statusCode;
      final message =
          _extractErrorMessage(response.data) ??
          error.message ??
          'Unknown error';

      if (statusCode != null) {
        return createExceptionFromStatus(
          statusCode,
          message,
          originalError: error,
        );
      }

      return ChanomhubException(
        message,
        statusCode: statusCode,
        originalError: error,
      );
    }

    return ChanomhubException(
      error.message ?? 'An unknown error occurred',
      originalError: error,
    );
  }

  /// Attempts to extract a readable error message from the API response body.
  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('message')) {
        return data['message'].toString();
      } else if (data.containsKey('error')) {
        return data['error'].toString();
      }
    } else if (data is String) {
      return data;
    }
    return null;
  }
}
