import 'package:equatable/equatable.dart';

class UserMetaData extends Equatable {
  const UserMetaData({
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
  });

  final int postCount;
  final int followerCount;
  final int followingCount;

  @override
  List<Object?> get props => [postCount, followingCount, followerCount];
}
