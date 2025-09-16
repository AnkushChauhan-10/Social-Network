import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

abstract class PostQueryRepo {
  const PostQueryRepo();

  FutureResult<Post> getPostById(String id);
  FutureResult<bool> isLikedByUser(String posId,String uId);
}
