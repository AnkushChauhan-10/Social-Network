import 'package:social_network/core/utils/typedef.dart';

abstract class SessionRepo{
  const SessionRepo();

  FutureResult<void> saveSession(String uId);
  FutureResult<String> getUid();
  FutureResult<void> clearSession();
}