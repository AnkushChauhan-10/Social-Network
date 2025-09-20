import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

abstract class PostCollectionRepo {
  const PostCollectionRepo();

  FutureResult<List<Post>> feedPosts();
}
