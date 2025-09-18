import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/shared/media/data/data_source/media_remote_data_source.dart';
import 'package:social_network/shared/media/domain/repo/media_repo.dart';
import 'package:path/path.dart' as path;

@LazySingleton(as: MediaRepo)
class MediaRepoImpl extends MediaRepo {
  const MediaRepoImpl({
    required MediaRemoteDataSource mediaRemoteDataSource,
    required Connectivity connectivity,
  }) : _mediaRemoteDataSource = mediaRemoteDataSource,
       _connectivity = connectivity;

  final MediaRemoteDataSource _mediaRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<String> uploadMedia(String folder, File media) async {
    try {
      if (!await _connectivity.isInternet) {
        throw NetworkException("No Internet");
      }
      final extension = path.extension(media.path).isNotEmpty
          ? path.extension(media.path)
          : '.jpg';
      final storagePath =
          '$folder/${DateTime.now().millisecondsSinceEpoch}$extension';
      var url = await _mediaRemoteDataSource.uploadMedia(storagePath, media);
      return Result.success(url);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
