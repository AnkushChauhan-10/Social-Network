import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class PostActionRemoteDataSource {
  const PostActionRemoteDataSource();

  Future<bool> likePost(String uId, String postId);

  Future<bool> dislikePost(String uId, String postId);
}

@LazySingleton(as: PostActionRemoteDataSource)
class PostActionRemoteDataSourceImpl extends PostActionRemoteDataSource {
  final FirebaseFirestore _fireStore;
  final String _collection = "posts";

  const PostActionRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;

  @override
  Future<bool> dislikePost(String uId, String postId) async {
    var postRef = _fireStore.collection(_collection).doc(postId);
    var likeRef = postRef.collection("likes").doc(uId);
    return await _fireStore.runTransaction<bool>((transaction) async {
      var likeDoc = await transaction.get(likeRef);
      if (likeDoc.exists) {
        transaction.delete(likeRef);
        transaction.update(postRef, {"likesCount": FieldValue.increment(-1)});
      }
      return true;
    });
  }

  @override
  Future<bool> likePost(String uId, String postId) async {
    var postRef = _fireStore.collection(_collection).doc(postId);
    var likeRef = postRef.collection("likes").doc(uId);
    return await _fireStore.runTransaction<bool>((transaction) async {
      var likeDoc = await transaction.get(likeRef);
      if (!likeDoc.exists) {
        transaction.set(likeRef, {
          "userId": uId,
          "likeAt": FieldValue.serverTimestamp(),
        });
        transaction.update(postRef, {"likesCount": FieldValue.increment(1)});
      }
      return true;
    });
  }
}
