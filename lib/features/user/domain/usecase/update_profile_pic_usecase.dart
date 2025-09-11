import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/session/domain/repository/session_repo.dart';
import 'package:social_network/features/user/domain/repository/user_repo.dart';

@injectable
class UpdateProfilePicUseCase
    extends UseCaseWithParam<FutureResult<void>, File> {
  const UpdateProfilePicUseCase({
    required UserRepo userRepo,
    required SessionRepo sessionRepo,
  }) : _userRepo = userRepo,
       _sessionRepo = sessionRepo;

  final UserRepo _userRepo;
  final SessionRepo _sessionRepo;

  @override
  FutureResult<void> call(File param) async {
    var session = await _sessionRepo.getUid();
    if (!session.isSuccess) return session;
    var uId = (session as Success<String>).data;
    var uploadPic = await _userRepo.updateProfilePic(uId, param);
    return uploadPic;
  }
}
