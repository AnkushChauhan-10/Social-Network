import 'dart:io';

import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

abstract class UserRepo {
  const UserRepo();

  FutureResult<bool> createUser(User user);

  FutureResult<User> getUser(String uId);

  FutureResult<bool> clearUserCache();

  FutureResult<String> updateProfilePicUrl(String uId,String url);
}
