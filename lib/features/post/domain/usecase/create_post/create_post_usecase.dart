import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_creation_repo.dart';
import 'package:social_network/features/session/domain/repository/session_repo.dart';

@injectable
class CreatePostUseCase
    extends UseCaseWithParam<FutureResult<void>, CreatePostUseCaseParam> {
  const CreatePostUseCase({
    required PostCreationRepo postCreationRepo,
    required SessionRepo sessionRepo,
  }) : _postCreationRepo = postCreationRepo,
       _sessionRepo = sessionRepo;

  final PostCreationRepo _postCreationRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<void> call(CreatePostUseCaseParam param) async {
    var session = await _sessionRepo.getUid();
    if (!session.isSuccess) return session;
    var userId = (session as Success<String>).data;
    var timeStamp = DateTime.now().toUtc();
    var post = Post.create(
      userId: userId,
      content: param.content,
      createdAt: timeStamp,
    );
    var result = await _postCreationRepo.createPost(post, param.media);
    return result;
  }
}

class CreatePostUseCaseParam {
  const CreatePostUseCaseParam(this.content, this.media);

  final String content;
  final File media;
}
