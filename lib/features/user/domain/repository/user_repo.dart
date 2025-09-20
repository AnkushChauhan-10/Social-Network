import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/create_user.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

abstract class UserRepo {
  const UserRepo();

  FutureResult<User> createUser(CreateUser createUser);

  FutureResult<User> getUser(String uId);

  Future<void> registerUserPost({
    required String userId,
    required String postId,
    required Transaction tx,
  });

  FutureResult<bool> clearUserCache();

  FutureResult<String> updateProfilePicUrl(String uId, String url);
}
