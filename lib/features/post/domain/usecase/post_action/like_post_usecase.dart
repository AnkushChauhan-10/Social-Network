import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/post/domain/repository/post_action_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class LikePostUseCase extends UseCaseWithParam<FutureResult<bool>, String> {
  const LikePostUseCase({
    required PostActionRepo postActionRepo,
    required SessionRepo sessionRepo,
  }) : _sessionRepo = sessionRepo,
       _postActionRepo = postActionRepo;

  final PostActionRepo _postActionRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<bool> call(String param) async {
    var session = await _sessionRepo.getUid();
    var result = await session.fold<FutureResult<bool>>(
      (uId) async => await _postActionRepo.like(uId, param),
      (f) async => Result.failure(f),
    );
    return result;
  }
}
