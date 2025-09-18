import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/data/data_source/post_creation_remote_data_source.dart';
import 'package:social_network/features/post/data/models/post_model.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_creation_repo.dart';

@LazySingleton(as: PostCreationRepo)
class PostCreationRepoImpl extends PostCreationRepo {
  const PostCreationRepoImpl({
    required PostCreationRemoteDataSource postCreationRemoteDataSource,
  }) : _postCreationRemoteDataSource = postCreationRemoteDataSource;

  final PostCreationRemoteDataSource _postCreationRemoteDataSource;

  @override
  FutureResult<void> createPost(Post post) async {
    try {
      var postModel = PostModel.fromEntity(post);
      await _postCreationRemoteDataSource.createPost(postModel.toJson);
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
