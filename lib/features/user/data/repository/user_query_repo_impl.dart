import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/data/data_source/user_remote_data_source.dart';
import 'package:social_network/features/user/data/model/user_model.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/user_query_repo.dart';

@Injectable(as: UserQueryRepo)
class UserQueryRepoImpl extends UserQueryRepo {
  const UserQueryRepoImpl({
    required Connectivity connectivity,
    required UserRemoteDataSource userRemoteDataSource,
  }) : _connectivity = connectivity,
       _userRemoteDataSource = userRemoteDataSource;

  final UserRemoteDataSource _userRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<User> getUserById(String userId) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var data = await _userRemoteDataSource.fetchUser(userId);
      var userModel = UserModel.fromJson(data);
      return Result.success(userModel);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
