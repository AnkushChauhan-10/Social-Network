import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/repository/post_collection_repo.dart';

@LazySingleton(as: PostCollectionRepo)
class PostCollectionRepoImpl extends PostCollectionRepo {
  const PostCollectionRepoImpl();

  @override
  FutureResult<List<String>> feedPosts(String uId) async {
    return Result.success(List.generate(20, (i) => "p7DgWUWIUXfVmN5GGXSN"));
  }

  @override
  FutureResult<List<String>> usersPost(String uId) {
    // TODO: implement usersPost
    throw UnimplementedError();
  }
}
