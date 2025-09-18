import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post_detail.dart';
import 'package:social_network/features/post/domain/repository/post_query_repo.dart';
import 'package:social_network/features/user/domain/repository/user_query_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class GetPostDetailsUseCase
    extends UseCaseWithParam<FutureResult<PostDetail>, String> {
  const GetPostDetailsUseCase({
    required PostQueryRepo postQueryRepo,
    required SessionRepo sessionRepo,
    required UserQueryRepo userQueryRepo,
  }) : _postQueryRepo = postQueryRepo,
       _sessionRepo = sessionRepo,
       _userQueryRepo = userQueryRepo;

  final PostQueryRepo _postQueryRepo;
  final SessionRepo _sessionRepo;
  final UserQueryRepo _userQueryRepo;

  @override
  FutureResult<PostDetail> call(String param) async {
    var post = await _postQueryRepo.getPostById(param);
    var result = await post.fold<FutureResult<PostDetail>>((p) async {
      var user = await _userQueryRepo.getUserById(p.userId);
      return await user.fold((u) async {
        var session = await _sessionRepo.getUid();
        return await session.fold((uId) async {
          var isLiked = await _postQueryRepo.isLikedByUser(p.id, uId);
          var postDetail = PostDetail(
            post: p,
            userName: u.name,
            userProfileUrl: u.profilePicUrl,
            isLike: isLiked.fold((s) => s, (f) => true),
          );
          return Result.success(postDetail);
        }, (f) async => Result.failure(f));
      }, (f) async => Result.failure(f));
    }, (f) async => Result.failure(f));
    return result;
  }
}
