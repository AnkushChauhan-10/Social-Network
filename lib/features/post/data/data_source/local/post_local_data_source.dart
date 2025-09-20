import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/utils/typedef.dart';

abstract class PostLocalDataSource {
  const PostLocalDataSource();

  Future<DataMap> getPostById(String id);

  Future<bool> isPostLiked(String id);

  Future<bool> cachePost(String id, DataMap val);

  Future<bool> setLike(String id, bool like);
}

final class PostLocalDataSourceImpl extends PostLocalDataSource {
  const PostLocalDataSourceImpl({@Named("Post_box") required Box hive})
    : _hive = hive;

  final Box _hive;

  @override
  Future<DataMap> getPostById(String id) async {
    var raw = await _hive.get(id);
    if (raw == null) throw CacheException();
    final data = Map<String, dynamic>.from(raw as Map);
    return data;
  }

  @override
  Future<bool> isPostLiked(String id) async {
    var raw = await _hive.get(id);
    if (raw == null) throw CacheException();
    final data = Map<String, dynamic>.from(raw as Map);
    return data[""];
  }

  @override
  Future<bool> cachePost(String id, DataMap val) {
    // TODO: implement cachePost
    throw UnimplementedError();
  }

  @override
  Future<bool> setLike(String id, bool like) {
    // TODO: implement setLike
    throw UnimplementedError();
  }
}
