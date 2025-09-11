import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uId,
    required super.name,
    required super.email,
    required super.profilePicUrl,
    required super.userName,
  });

  factory UserModel.fromEntity(User user) => UserModel(
    uId: user.uId,
    name: user.name,
    email: user.email,
    profilePicUrl: user.profilePicUrl,
    userName: user.userName,
  );

  factory UserModel.fromJson(DataMap val) => UserModel(
    uId: val["u_id"],
    name: val["name"],
    email: val["email"],
    profilePicUrl: val["profile_pic_url"],
    userName: val['user_name'],
  );

  UserModel copyWith({String? profilePicUrl}) => UserModel(
    uId: uId,
    name: name,
    email: email,
    profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    userName: userName,
  );

  DataMap get toJson => {
    "u_id": uId,
    "user_name": userName,
    "name": name,
    "email": email,
    "profile_pic_url": profilePicUrl,
  };
}
