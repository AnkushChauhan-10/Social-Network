import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user_meta_data.dart';

class UserMetaDataModel extends UserMetaData {
  static const postCountKey = "postCount";
  static const followerCountKey = "followerCount";
  static const followingCountKey = "followingCount";

  const UserMetaDataModel({
    required super.postCount,
    required super.followerCount,
    required super.followingCount,
  });

  factory UserMetaDataModel.fromJson(DataMap val) => UserMetaDataModel(
    postCount: val[postCountKey],
    followerCount: val[followerCountKey],
    followingCount: val[followingCountKey],
  );

  factory UserMetaDataModel.fromEntity(UserMetaData val) => UserMetaDataModel(
    postCount: val.postCount,
    followerCount: val.followerCount,
    followingCount: val.followingCount,
  );

  DataMap get toJson => {
    postCountKey: postCount,
    followerCountKey: followerCount,
    followingCountKey: followingCount,
  };
}
