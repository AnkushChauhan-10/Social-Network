import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/usecase/get_user_usecase.dart';
import 'package:social_network/features/user/domain/usecase/update_profile_pic_usecase.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_state.dart';

@injectable
class ProfileOnBoardingCubit extends Cubit<ProfileOnBoardingState> {
  ProfileOnBoardingCubit({
    required UpdateProfilePicUseCase updateProfilePicUseCase,
    required GetUserUseCase getUserUseCase,
  }) : _getUserUseCase = getUserUseCase,
       _updateProfilePicUseCase = updateProfilePicUseCase,
       super(AddingProfilePic());

  final UpdateProfilePicUseCase _updateProfilePicUseCase;
  final GetUserUseCase _getUserUseCase;

  void skipProfilePic() async {
    var user = await _getUserUseCase();
    var newState = user.fold(
          (s) => WelcomeUser(s),
          (f) => AddingProfilePicError(f.message),
    );
    emit(newState);
  }

  void addProfilePic(File image) async {
    emit(AddingProfilePicLoading());
    var uploadPic = await _updateProfilePicUseCase.call(image);
    var result = await uploadPic.fold<FutureResult<User>>((s) async {
      var user = await _getUserUseCase();
      return user;
    }, (f) async => Result.failure(f));
    var newState = result.fold(
      (s) => WelcomeUser(s),
      (f) => AddingProfilePicError(f.message),
    );
    emit(newState);
  }

  void goToWelcome() {
    var s  = state;
    if(s is ShowProfilePic) {
      emit(WelcomeUser(s.user));
    }
  }
}
