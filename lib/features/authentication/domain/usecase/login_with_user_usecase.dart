import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class LoginUserIdUseCase
    extends UseCaseWithParam<FutureResult<String>, String> {
  const LoginUserIdUseCase({required SessionRepo sessionRepo})
    : _sessionRepo = sessionRepo;

  final SessionRepo _sessionRepo;

  @override
  FutureResult<String> call(String param) async {
    var session = await _sessionRepo.saveSession(param);
    return session.fold((s) => Result.success(param), (f) => Result.failure(f));
  }
}
