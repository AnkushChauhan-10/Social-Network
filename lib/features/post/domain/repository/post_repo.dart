import 'dart:io';

import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

abstract class PostRepo{
  const PostRepo();

  FutureResult<List<Post>> usersPost(String uId);

  FutureResult<void> createPost(Post post,File media);
}