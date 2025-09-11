import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/authentication/domain/repository/auth_repo.dart';
import 'package:social_network/features/session/domain/repository/session_repo.dart';

@injectable
class LogInUseCase extends UseCaseWithParam<FutureResult<String>, LogInParam> {
  const LogInUseCase({
    required AuthRepo authRepo,
    required SessionRepo sessionRepo,
  }) : _authRepo = authRepo,
       _sessionRepo = sessionRepo;

  final AuthRepo _authRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<String> call(LogInParam param) async {
    var logIn = await _authRepo.login(param.email, param.password);
    var result = await logIn.fold<FutureResult<String>>(
      (uId) async => Result.success(uId),
      (error) async => Result.failure(error),
    );
    await result.onSuccess((uId) async => await _sessionRepo.saveSession(uId));
    return result;
  }
}

class LogInParam {
  const LogInParam({required this.email, required this.password});

  final String email;
  final String password;
}
