import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/session/domain/repository/session_repo.dart';

@injectable
class CheckSessionUseCase extends UseCaseWithOutParam<FutureResult<bool>> {
  const CheckSessionUseCase({required SessionRepo sessionRepo})
    : _sessionRepo = sessionRepo;

  final SessionRepo _sessionRepo;

  @override
  FutureResult<bool> call() async => (await _sessionRepo.getUid()).fold(
    (i) => Result.success(i.isNotEmpty),
    (f) => Result.failure(f),
  );
}
