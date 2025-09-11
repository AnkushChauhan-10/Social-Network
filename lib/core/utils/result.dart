import 'package:social_network/core/error/failure.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T data) => Success._(data);

  factory Result.failure(FailureType error) => Failure._(error);

  F fold<F>(F Function(T data) s, F Function(FailureType error) f);

  bool get isSuccess => this is Success;

  F? onSuccess<F>(F Function(T data) s);

  F? onFailure<F>(F Function(FailureType data) f);
}

final class Success<T> extends Result<T> {
  const Success._(this.data);

  final T data;

  @override
  F fold<F>(F Function(T data) s, F Function(FailureType error) f) =>
      s.call(data);

  @override
  onFailure<F>(Function(FailureType data) f) => null;

  @override
  onSuccess<F>(Function(T data) s) => s.call(data);
}

final class Failure<T> extends Result<T> {
  const Failure._(this.error);

  final FailureType error;

  @override
  F fold<F>(F Function(T data) s, F Function(FailureType error) f) =>
      f.call(error);

  @override
  onFailure<F>(Function(FailureType data) f) => f.call(error);

  @override
  onSuccess<F>(Function(T data) s) => null;
}
