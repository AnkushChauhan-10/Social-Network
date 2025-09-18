import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

class UserModel extends User {
  static const String uIdKey = "u_id";
  static const String nameKey = "name";
  static const String emailKey = "email";
  static const String profilePicUrlKey = "profile_pic_url";
  static const String userNameKey = "user_name";

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
    uId: val[uIdKey],
    name: val[nameKey],
    email: val[emailKey],
    profilePicUrl: val[profilePicUrlKey],
    userName: val[userNameKey],
  );

  UserModel copyWith({String? profilePicUrl}) => UserModel(
    uId: uId,
    name: name,
    email: email,
    profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    userName: userName,
  );

  DataMap get toJson => {
    uIdKey: uId,
    userNameKey: userName,
    nameKey: name,
    emailKey: email,
    profilePicUrlKey: profilePicUrl,
  };
}
