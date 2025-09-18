import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

abstract class AccountPickerRepo {
  const AccountPickerRepo();

  Result<List<User>> getAccounts();

  FutureResult<void> addAndUpdateUser(User user);

  FutureResult<void> updateAccountProfileUrl(String uid, String url);

  FutureResult<void> removeUser(User user);

  FutureResult<void> clearList();
}
