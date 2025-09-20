import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/data/data_source/remote/post_collection_remote_data_source.dart';
import 'package:social_network/features/post/data/models/post_model.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_collection_repo.dart';

@LazySingleton(as: PostCollectionRepo)
class PostCollectionRepoImpl extends PostCollectionRepo {
  const PostCollectionRepoImpl({
    required Connectivity connectivity,
    required PostCollectionRemoteDataSource postCollectionDataSource,
  }) : _collectionRemoteDataSource = postCollectionDataSource,
       _connectivity = connectivity;
  final PostCollectionRemoteDataSource _collectionRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<List<Post>> feedPosts() async {
    try {
      if (!await _connectivity.isInternet) throw NetworkException();
      var data = await _collectionRemoteDataSource.getFeedPost();
      List<Post> posts = data
          .map<Post>((val) => PostModel.fromJson(val))
          .toList();
      return Result.success(posts);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on FirebaseFirestore catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
