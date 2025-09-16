import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/post/domain/usecase/post_action/dislike_post_usecase.dart';
import 'package:social_network/features/post/domain/usecase/post_action/like_post_usecase.dart';
import 'package:social_network/features/post/domain/usecase/post_query/get_post_detail_usecase.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_state.dart';

@injectable
class PostCubit extends Cubit<PostState> {
  PostCubit({
    required GetPostDetailsUseCase postDetailsUseCase,
    required LikePostUseCase likePostUseCase,
    required DislikePostUseCase dislikePostUseCase,
  }) : _postDetailsUseCase = postDetailsUseCase,
       _dislikePostUseCase = dislikePostUseCase,
       _likePostUseCase = likePostUseCase,
       super(PostInitial());

  final GetPostDetailsUseCase _postDetailsUseCase;
  final LikePostUseCase _likePostUseCase;
  final DislikePostUseCase _dislikePostUseCase;

  void loadPost(String id) async {
    emit(PostLoading());
    var postResult = await _postDetailsUseCase(id);
    var newState = postResult.fold<PostState>(
      (post) => PostSuccess(post, post.isLike, false),
      (f) => PostError(f.message),
    );
    emit(newState);
  }

  void likePost() async {
    var s = state;
    if (s is PostSuccess && !s.isLike) {
      emit(PostSuccess(s.postDetail, true, s.isSave));
      var like = await _likePostUseCase(s.postDetail.post.id);
      var newState = like.fold<PostState>(
        (post) => PostSuccess(s.postDetail, post, s.isSave),
        (f) => PostError(f.message),
      );
      emit(newState);
    }
  }

  void dislikePost() async {
    var s = state;
    if (s is PostSuccess && s.isLike) {
      emit(PostSuccess(s.postDetail, false, s.isSave));
      var like = await _dislikePostUseCase(s.postDetail.post.id);
      var newState = like.fold<PostState>(
        (post) => PostSuccess(s.postDetail, !post, s.isSave),
        (f) => PostError(f.message),
      );
      emit(newState);
    }
  }
}
