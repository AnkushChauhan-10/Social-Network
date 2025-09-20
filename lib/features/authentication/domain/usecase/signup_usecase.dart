import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/authentication/domain/repository/auth_repo.dart';
import 'package:social_network/features/user/domain/entities/create_user.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class SignUpUseCase extends UseCaseWithParam<FutureResult<User>, SignUpParam> {
  const SignUpUseCase({
    required SessionRepo sessionRepo,
    required AuthRepo authRepo,
    required UserRepo userRepo,
  }) : _authRepo = authRepo,
       _sessionRepo = sessionRepo,
       _userRepo = userRepo;

  final AuthRepo _authRepo;
  final SessionRepo _sessionRepo;
  final UserRepo _userRepo;

  @override
  FutureResult<User> call(SignUpParam param) async {
    var signUp = await _authRepo.signup(param.email, param.password);
    var result = await signUp.fold<FutureResult<User>>((uId) async {
      CreateUser createUser = CreateUser(
        id: uId,
        name: param.name,
        email: param.email,
        userName: param.userName,
      );
      var userCreated = await _userRepo.createUser(createUser);
      return await userCreated.fold<FutureResult<User>>(
        (i) async => Result.success(i),
        (error) async => Result.failure(error),
      );
    }, (error) async => Result.failure(error));
    await result.onSuccess(
      (user) async => await _sessionRepo.saveSession(user.uId),
    );
    return result;
  }
}

class SignUpParam {
  const SignUpParam({
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
  final String userName;
}
