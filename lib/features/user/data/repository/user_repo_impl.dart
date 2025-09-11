import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/storage/supabase_media_data_source.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/data/data_source/user_local_data_source.dart';
import 'package:social_network/features/user/data/data_source/user_remote_data_source.dart';
import 'package:social_network/features/user/data/model/user_model.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';

@LazySingleton(as: UserRepo)
class UserRepoImpl extends UserRepo {
  const UserRepoImpl({
    required Connectivity connectivity,
    required UserRemoteDataSource userRemoteDataSource,
    required UserLocalDataSource userLocalDataSource,
    required SupabaseMediaDataSource supabaseMediaDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource,
       _userLocalDataSource = userLocalDataSource,
       _supabaseMediaDataSource = supabaseMediaDataSource,
       _connectivity = connectivity;

  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final SupabaseMediaDataSource _supabaseMediaDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<bool> createUser(User user) async {
    if (!await _connectivity.isInternet) throw NetworkException("No Internet");
    var defaultProfile = await _userRemoteDataSource.getDefaultProfilePic();
    var userModel = UserModel.fromEntity(
      user,
    ).copyWith(profilePicUrl: defaultProfile);
    try {
      await _userRemoteDataSource.createUser(user.uId, userModel.toJson);
      return Result.success(true);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<User> getUser(String uId) async {
    try {
      UserModel userModel;
      if (await _connectivity.isInternet) {
        var data = await _userRemoteDataSource.fetchUser(uId);
        userModel = UserModel.fromJson(data);
        await _userLocalDataSource.cacheUser(userModel.toJson);
      } else {
        var data = await _userLocalDataSource.getCachedUser();
        userModel = UserModel.fromJson(data);
      }
      return Result.success(userModel);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<bool> clearUserCache() async {
    try {
      await _userLocalDataSource.clearCacheUser();
      return Result.success(true);
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<String> updateProfilePic(String uId, File image) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var url = await _supabaseMediaDataSource.uploadMedia(
        "$uId/profile_pic",
        image,
      );
      await _userRemoteDataSource.updateProfilePic(uId, url);
      return Result.success(url);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
