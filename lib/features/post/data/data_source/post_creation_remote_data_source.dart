import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostCreationRemoteDataSource {
  const PostCreationRemoteDataSource();

  Future<void> createPost(DataMap val);

  String generatePostId();
}

@LazySingleton(as: PostCreationRemoteDataSource)
class PostCreationRemoteDataSourceImpl extends PostCreationRemoteDataSource {
  const PostCreationRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  final String _collection = "posts";

  @override
  Future<void> createPost(DataMap val) async {
    await _fireStore.collection(_collection).doc(val["id"]).set(val);
  }

  @override
  String generatePostId() => _fireStore.collection(_collection).doc().id;
}
