import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uId,
    required this.name,
    required this.userName,
    required this.email,
    required this.profilePicUrl,
  });

  final String uId;
  final String userName;
  final String name;
  final String email;
  final String profilePicUrl;

  @override
  List<Object?> get props => [uId];
}
