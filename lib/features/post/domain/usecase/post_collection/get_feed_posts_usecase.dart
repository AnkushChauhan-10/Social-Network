import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_collection_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class GetFeedPostUseCase
    extends UseCaseWithParam<FutureResult<List<Post>>, GetFeedPostParam> {
  const GetFeedPostUseCase({
    required PostCollectionRepo postCollectionRepo,
    required SessionRepo sessionRepo,
  }) : _postCollectionRepo = postCollectionRepo,
       _sessionRepo = sessionRepo;

  final SessionRepo _sessionRepo;
  final PostCollectionRepo _postCollectionRepo;

  @override
  FutureResult<List<Post>> call(GetFeedPostParam param) async {
    var session = await _sessionRepo.getUid();
    var result = await session.fold<FutureResult<List<Post>>>(
      (uId) async => await _postCollectionRepo.feedPosts(),
      (f) async => Result.failure(f),
    );
    return result;
  }
}

class GetFeedPostParam {
  const GetFeedPostParam();
}
