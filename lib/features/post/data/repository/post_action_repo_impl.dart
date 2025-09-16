import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/data/data_source/post_action_remote_data_source.dart';
import 'package:social_network/features/post/domain/repository/post_action_repo.dart';

@LazySingleton(as: PostActionRepo)
class PostActionRepoImpl extends PostActionRepo {
  const PostActionRepoImpl({
    required Connectivity connectivity,
    required PostActionRemoteDataSource postActionRemoteDataSource,
  }) : _actionRemoteDataSource = postActionRemoteDataSource,
       _connectivity = connectivity;

  final PostActionRemoteDataSource _actionRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<bool> dislike(String uId, String postId) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var result = await _actionRemoteDataSource.dislikePost(uId, postId);
      return Result.success(result);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<bool> like(String uId, String postId) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var result = await _actionRemoteDataSource.likePost(uId, postId);
      return Result.success(result);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
