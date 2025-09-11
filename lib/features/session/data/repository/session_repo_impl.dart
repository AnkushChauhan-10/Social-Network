import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/session/data/data_source/session_local_data_source.dart';
import 'package:social_network/features/session/domain/repository/session_repo.dart';

@LazySingleton(as: SessionRepo)
class SessionRepoImpl extends SessionRepo {
  const SessionRepoImpl({
    required SessionLocalDataSource sessionLocalDataSource,
  }) : _sessionLocalDataSource = sessionLocalDataSource;

  final SessionLocalDataSource _sessionLocalDataSource;

  @override
  FutureResult<void> clearSession() async {
    try {
      await _sessionLocalDataSource.clearSession();
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<String> getUid() async {
    try {
      var uid = await _sessionLocalDataSource.getUid();
      return Result.success(uid);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<void> saveSession(String uId) async {
    try {
      await _sessionLocalDataSource.saveSession(uId);
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.failure(CacheFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
