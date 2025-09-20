import 'package:equatable/equatable.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object?> get props => [];
}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

final class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => [];
}
