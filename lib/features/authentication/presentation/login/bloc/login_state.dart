import 'package:equatable/equatable.dart';

sealed class LogInState extends Equatable {
  const LogInState();
}

final class LogInInitialState extends LogInState {
  const LogInInitialState();

  @override
  List<Object?> get props => [];
}

final class LogInLoadingState extends LogInState {
  const LogInLoadingState();

  @override
  List<Object?> get props => [];
}

final class LogInSuccessState extends LogInState {
  const LogInSuccessState(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class LogInFailureState extends LogInState {
  const LogInFailureState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
