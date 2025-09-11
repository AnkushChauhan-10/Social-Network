import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@module
abstract class HiveModule {
  @preResolve
  @Named("User_box")
  Future<Box> get userCacheBox async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return await Hive.openBox("User_box");
  }

  @preResolve
  @Named("account_list_box")
  Future<Box> get accountListBox async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return await Hive.openBox("account_list_box");
  }
}
