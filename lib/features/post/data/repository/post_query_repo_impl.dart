import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/data/data_source/post_query_remote_data_source.dart';
import 'package:social_network/features/post/data/models/post_model.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_query_repo.dart';

@LazySingleton(as: PostQueryRepo)
class PostQueryRepoImpl extends PostQueryRepo {
  const PostQueryRepoImpl({
    required Connectivity connectivity,
    required PostQueryRemoteDataSource postQueryRemoteDataSource,
  }) : _remoteDataSource = postQueryRemoteDataSource,
       _connectivity = connectivity;
  final PostQueryRemoteDataSource _remoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<Post> getPostById(String id) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var result = await _remoteDataSource.getPostById(id);
      var post = PostModel.fromJson(result);
      return Result.success(post);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureResult<bool> isLikedByUser(String posId, String uId) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var result = await _remoteDataSource.isLikedByUser(posId, uId);
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
