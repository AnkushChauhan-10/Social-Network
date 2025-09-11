import 'package:equatable/equatable.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  const Authenticated();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}

class ShowAccountPicker extends AuthState {
  final List<User> accounts;

  const ShowAccountPicker(this.accounts);

  @override
  List<Object?> get props => [];
}
