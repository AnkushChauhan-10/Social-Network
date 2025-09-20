import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/data/model/user_meta_data_model.dart';
import 'package:social_network/features/user/domain/entities/create_user.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/entities/user_meta_data.dart';

class UserModel extends User {
  static const String uIdKey = "u_id";
  static const String nameKey = "name";
  static const String emailKey = "email";
  static const String profilePicUrlKey = "profile_pic_url";
  static const String userNameKey = "user_name";
  static const String metaDataKey = "meta_data";

  const UserModel({
    required super.uId,
    required super.name,
    required super.email,
    required super.profilePicUrl,
    required super.userName,
    required super.metaData,
  });

  factory UserModel.fromEntity(User user) => UserModel(
    uId: user.uId,
    name: user.name,
    email: user.email,
    profilePicUrl: user.profilePicUrl,
    userName: user.userName,
    metaData: user.metaData,
  );

  factory UserModel.createUser(CreateUser createUser, String profileUrl) =>
      UserModel(
        uId: createUser.id,
        name: createUser.name,
        email: createUser.email,
        profilePicUrl: profileUrl,
        userName: createUser.userName,
        metaData: UserMetaData(
          postCount: 0,
          followerCount: 0,
          followingCount: 0,
        ),
      );

  factory UserModel.fromJson(DataMap val) => UserModel(
    uId: val[uIdKey],
    name: val[nameKey],
    email: val[emailKey],
    profilePicUrl: val[profilePicUrlKey],
    userName: val[userNameKey],
    metaData: UserMetaDataModel.fromJson(DataMap.from(val[metaDataKey])),
  );

  UserModel copyWith({String? profilePicUrl}) => UserModel(
    uId: uId,
    name: name,
    email: email,
    profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    userName: userName,
    metaData: metaData,
  );

  DataMap get toJson => {
    uIdKey: uId,
    userNameKey: userName,
    nameKey: name,
    emailKey: email,
    profilePicUrlKey: profilePicUrl,
    metaDataKey: UserMetaDataModel.fromEntity(metaData).toJson,
  };
}
