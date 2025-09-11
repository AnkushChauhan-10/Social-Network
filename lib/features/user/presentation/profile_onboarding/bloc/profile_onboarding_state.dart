import 'package:equatable/equatable.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

sealed class ProfileOnBoardingState extends Equatable {
  const ProfileOnBoardingState();
}

class AddingProfilePic extends ProfileOnBoardingState {
  const AddingProfilePic();

  @override
  List<Object?> get props => [];
}

final class AddingProfilePicLoading extends AddingProfilePic {
  const AddingProfilePicLoading();

  @override
  List<Object?> get props => [];
}

final class AddingProfilePicError extends AddingProfilePic {
  const AddingProfilePicError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ShowProfilePic extends ProfileOnBoardingState {
  final User user;

  const ShowProfilePic(this.user);

  @override
  List<Object?> get props => [];
}

final class WelcomeUser extends ProfileOnBoardingState {
  final User user;

  const WelcomeUser(this.user);

  @override
  List<Object?> get props => [];
}
