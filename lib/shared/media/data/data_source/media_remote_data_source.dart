import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MediaRemoteDataSource {
  const MediaRemoteDataSource();

  Future<String> uploadMedia(String path, File file);
}

@LazySingleton(as: MediaRemoteDataSource)
class MediaRemoteDataSourceImpl extends MediaRemoteDataSource {
  const MediaRemoteDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;
  final SupabaseClient _supabaseClient;
  final String _bucket = "user_media";

  @override
  Future<String> uploadMedia(String path, File file) async {
    var res = await _supabaseClient.storage.from(_bucket).upload(path, file);
    if (res.isNotEmpty) ;
    return _supabaseClient.storage.from(_bucket).getPublicUrl(path);
  }
}
