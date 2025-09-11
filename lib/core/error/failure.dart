sealed class FailureType {
  final String message;

  const FailureType(this.message);
}

class ServerFailure extends FailureType {
  const ServerFailure([String? message])
    : super(message ?? "Unexpected server failure");
}

class CacheFailure extends FailureType {
  const CacheFailure([String? message]) : super(message ?? "Cache failure");
}

class AuthFailure extends FailureType {
  const AuthFailure([String? message])
    : super(message ?? "Authentication failure");
}

class NetworkFailure extends FailureType {
  const NetworkFailure([String? message])
    : super(message ?? "No internet connection");
}

class UnknownFailure extends FailureType {
  const UnknownFailure([String? message]) : super(message ?? "Unknown Error");
}
