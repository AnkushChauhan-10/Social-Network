import 'package:equatable/equatable.dart';
import 'package:social_network/features/user/domain/entities/user_meta_data.dart';

class User extends Equatable {
  const User({
    required this.uId,
    required this.name,
    required this.userName,
    required this.email,
    required this.profilePicUrl,
    required this.metaData,
  });

  final String uId;
  final String userName;
  final String name;
  final String email;
  final String profilePicUrl;
  final UserMetaData metaData;

  @override
  List<Object?> get props => [uId];
}
