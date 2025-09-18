import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';

abstract class SessionLocalDataSource {
  const SessionLocalDataSource();

  Future<void> saveSession(String uid);

  Future<String> getUid();

  Future<void> clearSession();
}

@LazySingleton(as: SessionLocalDataSource)
class SessionLocalDataSourceImpl extends SessionLocalDataSource {
  const SessionLocalDataSourceImpl({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;
  final FlutterSecureStorage _secureStorage;
  final _key = "Uid_Key";

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: _key);
  }

  @override
  Future<String> getUid() async {
    var data = await _secureStorage.read(key: _key);
    if (data == null) throw CacheException();
    return data;
  }

  @override
  Future<void> saveSession(String uid) async {
    await _secureStorage.write(key: _key, value: uid);
  }
}
