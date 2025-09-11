import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostRemoteDataSource {
  const PostRemoteDataSource();

  Future<List<DataMap>> getUserPost(String uId);

  String generatePostId();

  Future<void> createPost(DataMap val);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  const PostRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  final String _collection = "posts";

  @override
  Future<List<DataMap>> getUserPost(String uId) {
    // TODO: implement getUserPost
    throw UnimplementedError();
  }

  @override
  Future<void> createPost(DataMap val) async {
    await _fireStore.collection(_collection).doc(val["id"]).set(val);
  }

  @override
  String generatePostId() => _fireStore.collection(_collection).doc().id;
}
