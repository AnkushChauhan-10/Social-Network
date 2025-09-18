import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/authentication/domain/repository/auth_repo.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class LogOutUseCase extends UseCaseWithOutParam<FutureResult<void>> {
  const LogOutUseCase({
    required AuthRepo authRepo,
    required UserRepo userRepo,
    required SessionRepo sessionRepo,
  }) : _authRepo = authRepo,
       _userRepo = userRepo,
       _sessionRepo = sessionRepo;

  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<void> call() async {
    var firebaseSignOut = await _authRepo.signOut();
    if (!firebaseSignOut.isSuccess) return firebaseSignOut;
    await _userRepo.clearUserCache();
    await _sessionRepo.clearSession();
    return Result.success(null);
  }
}
