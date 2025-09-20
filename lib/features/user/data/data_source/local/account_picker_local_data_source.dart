import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:collection/collection.dart';

abstract class AccountPickerLocalDataSource {
  const AccountPickerLocalDataSource();

  List<DataMap> getUsersList();

  Future<bool> addUser(String id, DataMap data);

  Future<bool> updateUser(String id, DataMap data);

  Future<bool> removeUser(String uId);

  Future<bool> clearUsersList();
}

@LazySingleton(as: AccountPickerLocalDataSource)
class AccountPickerLocalDataSourceImpl extends AccountPickerLocalDataSource {
  const AccountPickerLocalDataSourceImpl({
    @Named("account_list_box") required Box box,
  }) : _box = box;

  final Box _box;

  @override
  Future<bool> addUser(String id, DataMap data) async {
    if (_box.containsKey(id)) return false;
    await _box.put(id, data);
    return true;
  }

  @override
  Future<bool> clearUsersList() async {
    await _box.clear();
    return true;
  }

  @override
  List<DataMap> getUsersList() {
    List<DataMap> raw = _box.values.map((e) => DataMap.from(e)).toList();
    return raw;
  }

  @override
  Future<bool> removeUser(String uId) async {
    await _box.delete(uId);
    return true;
  }

  @override
  Future<bool> updateUser(String id, DataMap data) async {
    final existingUser = _box.get(id);
    if (existingUser == null) return false;
    if (!const DeepCollectionEquality().equals(existingUser, data)) {
      await _box.put(id, data);
      return true;
    }
    return false;
  }
}
