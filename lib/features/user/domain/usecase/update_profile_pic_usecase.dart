import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';
import 'package:social_network/shared/media/domain/repo/media_repo.dart';
import 'package:social_network/shared/session/domain/repository/session_repo.dart';

@injectable
class UpdateProfilePicUseCase
    extends UseCaseWithParam<FutureResult<void>, File> {
  const UpdateProfilePicUseCase({
    required UserRepo userRepo,
    required MediaRepo mediaRepo,
    required AccountPickerRepo accountPickerRepo,
    required SessionRepo sessionRepo,
  }) : _userRepo = userRepo,
       _mediaRepo = mediaRepo,
       _accountPickerRepo = accountPickerRepo,
       _sessionRepo = sessionRepo;

  final UserRepo _userRepo;
  final SessionRepo _sessionRepo;
  final MediaRepo _mediaRepo;
  final AccountPickerRepo _accountPickerRepo;

  @override
  FutureResult<void> call(File param) async {
    var session = await _sessionRepo.getUid();
    if (!session.isSuccess) return session;
    var uId = (session as Success<String>).data;
    var urlResult = await _mediaRepo.uploadMedia("$uId/profile_pic", param);
    var updateUrlResult = await urlResult.fold<FutureResult<void>>((url) async {
      var result = await _userRepo.updateProfilePicUrl(uId, url);
      if (result.isSuccess) {
        await _accountPickerRepo.updateAccountProfileUrl(uId, url);
      }
      return result;
    }, (f) async => Result.failure(f));
    return updateUrlResult;
  }
}
