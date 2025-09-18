import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class GetUserUseCase extends UseCaseWithOutParam<FutureResult<User>> {
  const GetUserUseCase({
    required UserRepo userRepo,
    required AccountPickerRepo accountPickerRepo,
    required SessionRepo sessionRepo,
  }) : _userRepo = userRepo,
       _accountPickerRepo = accountPickerRepo,
       _sessionRepo = sessionRepo;

  final UserRepo _userRepo;
  final AccountPickerRepo _accountPickerRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<User> call() async {
    var uidResult = await _sessionRepo.getUid();
    var user = await uidResult.fold<FutureResult<User>>(
      (uid) async => await _userRepo.getUser(uid),
      (f) async => Result.failure(f),
    );
    user.onSuccess((s) async {
      await _accountPickerRepo.addAndUpdateUser(s);
    });
    return user;
  }
}
