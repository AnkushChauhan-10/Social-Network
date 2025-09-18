import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/data/data_source/account_picker_local_data_source.dart';
import 'package:social_network/features/user/data/model/user_model.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart';

@LazySingleton(as: AccountPickerRepo)
class AccountPickerRepoImpl extends AccountPickerRepo {
  const AccountPickerRepoImpl({
    required AccountPickerLocalDataSource accountPickerLocalDataSource,
  }) : _accountPickerLocalDataSource = accountPickerLocalDataSource;

  final AccountPickerLocalDataSource _accountPickerLocalDataSource;

  @override
  FutureResult<void> addAndUpdateUser(User user) async {
    try {
      var userModel = UserModel.fromEntity(user);
      var isAdded = await _accountPickerLocalDataSource.addUser(
        userModel.uId,
        userModel.toJson,
      );
      if (!isAdded) {
        await _accountPickerLocalDataSource.updateUser(
          userModel.uId,
          userModel.toJson,
        );
      }
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> clearList() async {
    try {
      await _accountPickerLocalDataSource.clearUsersList();
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Result<List<User>> getAccounts() {
    try {
      var rawList = _accountPickerLocalDataSource.getUsersList();
      var accountList = rawList
          .map((data) => UserModel.fromJson(data))
          .toList();
      return Result.success(accountList);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> removeUser(User user) async {
    try {
      await _accountPickerLocalDataSource.removeUser(user.uId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> updateAccountProfileUrl(String uid, String url) async {
    try {
      await _accountPickerLocalDataSource.updateUser(uid, {
        UserModel.profilePicUrlKey: url,
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
