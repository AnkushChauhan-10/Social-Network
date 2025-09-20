import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/data/model/user_meta_data_model.dart';

abstract class UserRemoteDataSource {
  const UserRemoteDataSource();

  Future<void> createUser(String uId, DataMap user);

  Future<DataMap> fetchUser(String uId);

  Future<void> updateUser(String uId, DataMap user);

  Future<String> getDefaultProfilePic();

  Future<List<String>> getPosts(String id);

  Future<void> registerUserPost({
    required String userId,
    required String postId,
    required Transaction tx,
  });
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required FirebaseFirestore fireStore})
    : _fireStore = fireStore;
  final FirebaseFirestore _fireStore;
  final _collection = "users";

  @override
  Future<void> createUser(String uId, DataMap user) async {
    await _fireStore.collection(_collection).doc(uId).set(user);
  }

  @override
  Future<DataMap> fetchUser(String uId) async {
    var data = await _fireStore.collection(_collection).doc(uId).get();
    return data.data()!;
  }

  @override
  Future<void> updateUser(String uId, DataMap user) async {
    await _fireStore.collection(_collection).doc(uId).update(user);
  }

  @override
  Future<String> getDefaultProfilePic() async {
    final docRef = FirebaseFirestore.instance
        .collection('default_assets')
        .doc('profile_pic');
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final url = docSnapshot.data()?['url'] as String?;
      return url ?? "";
    } else {
      return "";
    }
  }

  @override
  Future<void> registerUserPost({
    required String userId,
    required String postId,
    required Transaction tx,
  }) async {
    var userRef = _fireStore.collection(_collection).doc(userId);
    var postRef = userRef.collection("posts").doc(postId);

    tx.update(userRef, {
      "meta.${UserMetaDataModel.postCountKey}": FieldValue.increment(1),
    });

    tx.set(postRef, {'id': postId, 'createdAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<List<String>> getPosts(String id) async {
    var posts = await _fireStore
        .collection(_collection)
        .doc(id)
        .collection("posts")
        .limit(10)
        .get();
    return posts.docChanges
        .map<String>((val) => DataMap.from(val.doc.data() ?? {})["id"])
        .toList();
  }
}
