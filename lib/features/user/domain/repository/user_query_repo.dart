import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/entities/user_meta_data.dart';

abstract class UserQueryRepo {
  const UserQueryRepo();

  FutureResult<User> getUserById(String userId);

  FutureResult<List<String>> getUserPosts(String userId);
}
