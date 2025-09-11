import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/repository/post_repo.dart';

@injectable
class GetUserPostsUseCase
    extends UseCaseWithParam<FutureResult<List<Post>>, String> {
  const GetUserPostsUseCase({required PostRepo postRepo})
    : _postRepo = postRepo;

  final PostRepo _postRepo;

  @override
  FutureResult<List<Post>> call(String param) async {
    return await _postRepo.usersPost(param);
  }
}
