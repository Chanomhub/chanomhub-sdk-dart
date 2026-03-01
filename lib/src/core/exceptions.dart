import 'package:dio/dio.dart';

/// Base exception for all Chanomhub SDK errors.
class ChanomhubException implements Exception {
  final String message;
  final int? statusCode;
  final String code;
  final dynamic originalError;

  const ChanomhubException(
    this.message, {
    this.statusCode,
    this.code = 'UNKNOWN_ERROR',
    this.originalError,
  });

  @override
  String toString() => 'ChanomhubException: $message (Code: $code, Status: $statusCode)';
}

/// Thrown when the user is not authenticated or their token has expired (401).
class AuthenticationException extends ChanomhubException {
  const AuthenticationException(String message, {dynamic originalError})
      : super(
          message,
          statusCode: 401,
          code: 'AUTHENTICATION_ERROR',
          originalError: originalError,
        );
}

/// Thrown when the user does not have permission to access a resource (403).
class AuthorizationException extends ChanomhubException {
  const AuthorizationException(String message, {dynamic originalError})
      : super(
          message,
          statusCode: 403,
          code: 'AUTHORIZATION_ERROR',
          originalError: originalError,
        );
}

/// Thrown when a requested resource is not found (404).
class NotFoundException extends ChanomhubException {
  const NotFoundException(String message, {dynamic originalError})
      : super(
          message,
          statusCode: 404,
          code: 'NOT_FOUND',
          originalError: originalError,
        );
}

/// Thrown for validation errors (400).
class ValidationException extends ChanomhubException {
  final Map<String, dynamic>? errors;

  const ValidationException(
    String message, {
    this.errors,
    dynamic originalError,
  }) : super(
          message,
          statusCode: 400,
          code: 'VALIDATION_ERROR',
          originalError: originalError,
        );
}

/// Thrown for rate limit errors (429).
class RateLimitException extends ChanomhubException {
  final int? retryAfter;

  const RateLimitException(
    String message, {
    this.retryAfter,
    dynamic originalError,
  }) : super(
          message,
          statusCode: 429,
          code: 'RATE_LIMIT',
          originalError: originalError,
        );
}

/// Thrown for network-related errors (timeouts, no connection, etc.).
class NetworkException extends ChanomhubException {
  const NetworkException(String message, {dynamic originalError})
      : super(
          message,
          statusCode: 0,
          code: 'NETWORK_ERROR',
          originalError: originalError,
        );
}

/// Thrown for unexpected server errors (500+).
class ServerException extends ChanomhubException {
  const ServerException(
    String message, {
    int? statusCode,
    dynamic originalError,
  }) : super(
          message,
          statusCode: statusCode,
          code: 'SERVER_ERROR',
          originalError: originalError,
        );
}

/// Helper to create a specific exception based on HTTP status code.
ChanomhubException createExceptionFromStatus(
  int status,
  String message, {
  dynamic originalError,
}) {
  switch (status) {
    case 400:
      return ValidationException(message, originalError: originalError);
    case 401:
      return AuthenticationException(message, originalError: originalError);
    case 403:
      return AuthorizationException(message, originalError: originalError);
    case 404:
      return NotFoundException(message, originalError: originalError);
    case 429:
      return RateLimitException(message, originalError: originalError);
    default:
      if (status >= 500) {
        return ServerException(
          message,
          statusCode: status,
          originalError: originalError,
        );
      }
      return ChanomhubException(
        message,
        statusCode: status,
        originalError: originalError,
      );
  }
}
