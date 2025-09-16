import 'package:social_network/core/utils/typedef.dart';

abstract class PostActionRepo {
  const PostActionRepo();

  FutureResult<bool> like(String uId, String postId);

  FutureResult<bool> dislike(String uId, String postId);
}
