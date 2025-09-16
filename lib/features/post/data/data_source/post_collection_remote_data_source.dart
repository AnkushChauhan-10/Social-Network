import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostCollectionRemoteDataSource {
  const PostCollectionRemoteDataSource();

  Future<List<DataMap>> getFeedPost(String uId);
}

@LazySingleton(as: PostCollectionRemoteDataSource)
class PostCollectionRemoteDataSourceImpl
    extends PostCollectionRemoteDataSource {
  final FirebaseFirestore _fireStore;

  const PostCollectionRemoteDataSourceImpl({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  @override
  Future<List<DataMap>> getFeedPost(String uId) async {
    // TODO: implement getFeedPost
    throw UnimplementedError();
  }
}
