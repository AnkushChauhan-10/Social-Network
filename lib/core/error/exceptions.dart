class ServerException implements Exception {
  final String message;

  ServerException([this.message = "Unexpected server error"]);
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = "Cache error"]);
}

class AuthException implements Exception {
  final String message;

  AuthException([this.message = "Authentication error"]);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "Network error"]);
}
