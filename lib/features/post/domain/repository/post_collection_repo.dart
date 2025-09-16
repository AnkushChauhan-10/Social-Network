import 'package:social_network/core/utils/typedef.dart';

abstract class PostCollectionRepo {
  const PostCollectionRepo();

  FutureResult<List<String>> feedPosts(String uId);

  FutureResult<List<String>> usersPost(String uId);
}
