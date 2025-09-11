import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class UserLocalDataSource {
  const UserLocalDataSource();

  Future<DataMap> getCachedUser();

  Future<void> cacheUser(DataMap val);

  Future<void> clearCacheUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl extends UserLocalDataSource {
  const UserLocalDataSourceImpl({@Named("User_box") required Box hive})
    : _hive = hive;

  final Box _hive;
  final String _currentUserKey = "current_user_key";

  @override
  Future<void> cacheUser(DataMap val) async {
    await _hive.put(_currentUserKey, val);
  }

  @override
  Future<DataMap> getCachedUser() async {
    var raw = await _hive.get(_currentUserKey);
    if (raw == null) throw CacheException();
    final data = Map<String, dynamic>.from(raw as Map);
    return data;
  }

  @override
  Future<void> clearCacheUser() async {
    await _hive.delete(_currentUserKey);
  }
}
