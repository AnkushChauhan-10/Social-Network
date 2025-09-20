import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/post/domain/usecase/post_collection/get_user_posts_usecase.dart';
import 'package:social_network/features/post/presentation/user_posts/bloc/user_post_state.dart';

@injectable
class UserPostCubit extends Cubit<UserPostState> {
  UserPostCubit({required GetUserPostsUseCase getUserPostUseCase})
    : _userPostUseCase = getUserPostUseCase,
      super(UserPostInitial());
  final GetUserPostsUseCase _userPostUseCase;

  void loadPost(String userId) async {
    emit(UserPostLoading(state.postList, true));
    var param = GetUserPostsParam(userId: userId, page: 0);
    var posts = await _userPostUseCase(param);
    var newState = posts.fold<UserPostState>((s) {
      var list = [...s, ...s, ...s, ...s, ...s, ...s, ...s, ...s, ...s];
      return UserPostSuccess(list, true);
    }, (f) => UserPostError(f.message, state.postList, true));
    emit(newState);
  }

  void load() async {
    emit(UserPostLoading(state.postList, true));
  }
}
