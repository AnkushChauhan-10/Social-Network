import 'dart:io';

import 'package:social_network/core/utils/typedef.dart';

abstract class MediaRepo {
  const MediaRepo();

  FutureResult<String> uploadMedia(String folder, File media);
}
