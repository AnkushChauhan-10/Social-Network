import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseMediaDataSource {
  const SupabaseMediaDataSource();

  Future<String> uploadMedia(String folder, File file);
}

@LazySingleton(as: SupabaseMediaDataSource)
class SupabaseMediaDataSourceImpl extends SupabaseMediaDataSource {
  const SupabaseMediaDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;
  final SupabaseClient _supabaseClient;
  final String _bucket = "user_media";

  @override
  Future<String> uploadMedia(String folder, File file) async {
    final extension = path.extension(file.path).isNotEmpty
        ? path.extension(file.path)
        : '.jpg';
    final storagePath =
        '$folder/${DateTime.now().millisecondsSinceEpoch}$extension';
    var res = await _supabaseClient.storage
        .from(_bucket)
        .upload(storagePath, file);
    if (res.isNotEmpty) ;
    return _supabaseClient.storage.from(_bucket).getPublicUrl(storagePath);
  }
}
