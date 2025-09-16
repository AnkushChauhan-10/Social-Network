import 'dart:io';

import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

abstract class PostCreationRepo {
  const PostCreationRepo();

  FutureResult<void> createPost(Post post, File media);
}
