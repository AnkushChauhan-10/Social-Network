import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostCollectionRemoteDataSource {
  const PostCollectionRemoteDataSource();

  Future<List<DataMap>> getFeedPost();
}

@LazySingleton(as: PostCollectionRemoteDataSource)
class PostCollectionRemoteDataSourceImpl
    extends PostCollectionRemoteDataSource {
  final FirebaseFirestore _fireStore;

  const PostCollectionRemoteDataSourceImpl({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;
  final String _collection = "posts";

  @override
  Future<List<DataMap>> getFeedPost() async {
    var posts = await _fireStore.collection(_collection).limit(10).get();
    return posts.docChanges
        .map<DataMap>((val) => val.doc.data() as DataMap)
        .toList();
  }
}
