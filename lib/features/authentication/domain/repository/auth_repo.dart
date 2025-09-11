import 'package:social_network/core/utils/typedef.dart';

abstract class AuthRepo {
  const AuthRepo();

  FutureResult<String> signup(String email, String password);

  FutureResult<String> login(String email, String password);

  FutureResult<void> signOut();
}
