import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_network/features/user/domain/usecase/get_user_usecase.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required GetUserUseCase getUserUseCase})
    : _getUserUseCase = getUserUseCase,
      super(ProfileInitial());
  final GetUserUseCase _getUserUseCase;

  void loadCurrentUser() async {
    emit(ProfileLoading());
    var userResult = await _getUserUseCase();
    var newState = userResult.fold<ProfileState>(
      (user) => ProfileSuccess(user),
      (f) => ProfileError(f.message),
    );
    emit(newState);
  }
}
