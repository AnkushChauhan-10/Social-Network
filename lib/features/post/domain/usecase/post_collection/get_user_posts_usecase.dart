import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_query_repo.dart';
import 'package:social_network/features/user/domain/repository/user_query_repo.dart';

@injectable
class GetUserPostsUseCase
    extends UseCaseWithParam<FutureResult<List<Post>>, GetUserPostsParam> {
  const GetUserPostsUseCase({
    required PostQueryRepo postQueryRepo,
    required UserQueryRepo userQueryRepo,
  }) : _postQueryRepo = postQueryRepo,
       _userQueryRepo = userQueryRepo;

  final PostQueryRepo _postQueryRepo;
  final UserQueryRepo _userQueryRepo;

  @override
  FutureResult<List<Post>> call(GetUserPostsParam param) async {
    var postsId = await _userQueryRepo.getUserPosts(param.userId);
    return await postsId.fold<FutureResult<List<Post>>>((ids) async {
      var list = <Post>[];
      for (var id in ids) {
        var post = await _postQueryRepo.getPostById(id);
        post.fold((s) => list.add(s), (f) {});
      }
      return Result.success(list);
    }, (f) async => Result.failure(f));
  }
}

class GetUserPostsParam {
  const GetUserPostsParam({required this.userId, required this.page});

  final String userId;
  final int page;
}
