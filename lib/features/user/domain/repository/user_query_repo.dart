import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

abstract class UserQueryRepo {
  const UserQueryRepo();

  FutureResult<User> getUserById(String userId);
}
