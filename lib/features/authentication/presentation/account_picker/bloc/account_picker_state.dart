import 'package:equatable/equatable.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

sealed class AccountPickerState extends Equatable {
  const AccountPickerState(this.list);

  final List<User> list;
}

final class AccountPickerInitial extends AccountPickerState {
  const AccountPickerInitial(super.list);

  @override
  List<Object?> get props => [];
}

final class AccountPickerLoading extends AccountPickerState {
  const AccountPickerLoading(super.list, this.user);

  final User user;

  @override
  List<Object?> get props => [];
}

final class AccountPikerSelected extends AccountPickerState {
  const AccountPikerSelected(this.user, super.list);

  final User user;

  @override
  List<Object?> get props => [];
}

final class AccountPickerEmpty extends AccountPickerState {
  const AccountPickerEmpty(this.message) : super(const <User>[]);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class AccountPickerError extends AccountPickerState {
  const AccountPickerError(this.message, super.list);

  final String message;

  @override
  List<Object?> get props => [message];
}
