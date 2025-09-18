import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_creation_repo.dart';
import 'package:social_network/shared/media/domain/repo/media_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class CreatePostUseCase
    extends UseCaseWithParam<FutureResult<void>, CreatePostUseCaseParam> {
  const CreatePostUseCase({
    required PostCreationRepo postCreationRepo,
    required SessionRepo sessionRepo,
    required MediaRepo mediaRepo,
  }) : _postCreationRepo = postCreationRepo,
       _sessionRepo = sessionRepo,
       _mediaRepo = mediaRepo;

  final PostCreationRepo _postCreationRepo;
  final MediaRepo _mediaRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<void> call(CreatePostUseCaseParam param) async {
    var session = await _sessionRepo.getUid();
    if (!session.isSuccess) return session;
    var userId = (session as Success<String>).data;
    var timeStamp = DateTime.now().toUtc();

    var getPostId = _postCreationRepo.generatePostId();

    return await getPostId.fold<FutureResult<void>>((postId) async {
      var urlResult = await _mediaRepo.uploadMedia(
        "$userId/$postId",
        param.media,
      );
      return await urlResult.fold((url) async {
        var post = Post.create(
          id: postId,
          userId: userId,
          content: param.content,
          mediaUrl: url,
          createdAt: timeStamp,
        );
        return await _postCreationRepo.createPost(post);
      }, (f) async => Result.failure(f));
    }, (f) async => Result.failure(f));
  }
}

class CreatePostUseCaseParam {
  const CreatePostUseCaseParam(this.content, this.media);

  final String content;
  final File media;
}
