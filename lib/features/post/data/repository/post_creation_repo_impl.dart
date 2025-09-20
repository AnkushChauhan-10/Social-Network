import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';

import 'package:social_network/features/post/data/models/post_model.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_creation_repo.dart';

import '../data_source/remote/post_creation_remote_data_source.dart';

@LazySingleton(as: PostCreationRepo)
class PostCreationRepoImpl extends PostCreationRepo {
  const PostCreationRepoImpl({
    required Connectivity connectivity,
    required PostCreationRemoteDataSource postCreationRemoteDataSource,
  }) : _postCreationRemoteDataSource = postCreationRemoteDataSource,
       _connectivity = connectivity;

  final PostCreationRemoteDataSource _postCreationRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<void> createPost(
    Post post, {
    Future<void> Function(Transaction tx)? transactionCallback,
  }) async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var postModel = PostModel.fromEntity(post);
      await _postCreationRemoteDataSource.createPost(
        postModel.toJson,
        transactionCallback: transactionCallback,
      );
      return Result.success(null);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Result<String> generatePostId() {
    try {
      return Result.success(_postCreationRemoteDataSource.generatePostId());
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
