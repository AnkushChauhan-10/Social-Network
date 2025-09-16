import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostQueryRemoteDataSource {
  const PostQueryRemoteDataSource();

  Future<DataMap> getPostById(String id);

  Future<bool> isLikedByUser(String postId, String uId);
}

@LazySingleton(as: PostQueryRemoteDataSource)
class PostQueryRemoteDataSourceImpl extends PostQueryRemoteDataSource {
  const PostQueryRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  final String _collection = "posts";

  @override
  Future<DataMap> getPostById(String id) async {
    var postRef = _fireStore.collection(_collection).doc(id);
    var post = await postRef.get();
    if (!post.exists) throw ServerException();
    return post.data()!;
  }

  @override
  Future<bool> isLikedByUser(String postId, String uId) async {
    var postRef = _fireStore
        .collection(_collection)
        .doc(postId)
        .collection("likes")
        .doc(uId);
    var check = await postRef.get();
    return check.exists;
  }
}
