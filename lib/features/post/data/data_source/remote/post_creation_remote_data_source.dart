import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostCreationRemoteDataSource {
  const PostCreationRemoteDataSource();

  Future<void> createPost(
    DataMap val, {
    Future<void> Function(Transaction tx)? transactionCallback,
  });

  String generatePostId();
}

@LazySingleton(as: PostCreationRemoteDataSource)
class PostCreationRemoteDataSourceImpl extends PostCreationRemoteDataSource {
  const PostCreationRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  final String _collection = "posts";

  @override
  Future<void> createPost(
    DataMap val, {
    Future<void> Function(Transaction tx)? transactionCallback,
  }) async {
    var post = _fireStore.collection(_collection).doc(val["id"]);
    await _fireStore.runTransaction((tx) async {
      tx.set(post, val);
      await transactionCallback?.call(tx);
    });
  }

  @override
  String generatePostId() => _fireStore.collection(_collection).doc().id;
}
