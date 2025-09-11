import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/data/data_source/post_remote_data_source.dart';
import 'package:social_network/core/storage/supabase_media_data_source.dart';
import 'package:social_network/features/post/data/models/post_model.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_repo.dart';

@LazySingleton(as: PostRepo)
class PostRepoImpl extends PostRepo {
  const PostRepoImpl({
    required PostRemoteDataSource postRemoteDataSource,
    required SupabaseMediaDataSource supabaseMediaDataSource,
  }) : _supabaseMediaDataSource = supabaseMediaDataSource,
       _postRemoteDataSource = postRemoteDataSource;

  final PostRemoteDataSource _postRemoteDataSource;
  final SupabaseMediaDataSource _supabaseMediaDataSource;

  @override
  FutureResult<List<Post>> usersPost(String uId) async {
    // TODO: implement usersPost
    throw UnimplementedError();
  }

  @override
  FutureResult<void> createPost(Post post, File media) async {
    try {
      var postId = _postRemoteDataSource.generatePostId();
      var mediaUrl = await _supabaseMediaDataSource.uploadMedia(
        "${post.userId}/${post.id}",
        media,
      );
      var postModel = PostModel.fromEntity(
        post,
      ).copyWith(id: postId, mediaUrl: mediaUrl);
      await _postRemoteDataSource.createPost(postModel.toJson);
      return Result.success(null);
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
